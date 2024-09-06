use clap::{Parser, Subcommand};
use regex::Regex;
use serde::{Deserialize, Serialize};
use std::error;
use std::fs::File;
use std::io::BufReader;

mod search;
use search::search;

#[derive(Parser)]
#[command(about, long_about = None)]
struct Args {
    #[command(subcommand)]
    command: Option<Commands>,
}

#[derive(Subcommand)]
enum Commands {
    /// Lists all workspaces
    List {
        #[arg(short, long)]
        format: Option<String>,
        #[arg(short, long)]
        tag: Option<Vec<String>>,
    },
    Add {
        #[arg(short, long)]
        name: String,
        #[arg(short, long)]
        path: Option<String>,
        #[arg(short, long)]
        tag: Option<Vec<String>>,
    },
    Remove {
        #[arg(short, long)]
        name: String,
    },
    Path {
        #[arg(short, long)]
        name: String,
    },
    Config {},
}

fn main() {
    let args = Args::parse();

    let workspaces = load_workspaces().unwrap_or(vec![]);

    if args.command.is_none() {
        let items = workspaces.iter().map(|w| w.name.clone()).collect();

        let item = search(items);
        if item.is_none() {
            std::process::exit(1);
        }
        let item = item.unwrap();

        let workspace = workspaces.iter().find(|w| w.name == item).unwrap();

        use tmux_interface::{HasSession, NewSession, NewWindow, SendKeys, SwitchClient, Tmux};

        let v = Tmux::new()
            .add_command(HasSession::new().target_session(workspace.name.clone()))
            .output()
            .unwrap();

        if v.status().code() == Some(0) {
            Tmux::new()
                .add_command(
                    SwitchClient::new().target_session(format!("{}", workspace.name.clone())),
                )
                .output()
                .unwrap();
            std::process::exit(0);
        }

        let windows = workspace.windows.clone().unwrap_or(vec![]);
        let first_window = match windows.len() {
            0 => None,
            _ => windows[0].clone(),
        };
        let rest_of_windows = match windows.len() {
            0 => vec![],
            _ => windows[1..].to_vec(),
        };

        let new_session = match first_window.map(|win| win.clone().name).flatten() {
            Some(name) => NewSession::new()
                .session_name(workspace.name.clone())
                .detached()
                .window_name(name)
                .start_directory(workspace.path.clone()),
            None => NewSession::new()
                .session_name(workspace.name.clone())
                .detached()
                .start_directory(workspace.path.clone()),
        };

        Tmux::new().add_command(new_session).output().unwrap();

        for window in rest_of_windows {
            let new_window = match window.map(|win| win.clone().name).flatten() {
                Some(name) => NewWindow::new()
                    .target_window(format!("{}:", workspace.name))
                    .start_directory(workspace.path.clone())
                    .window_name(name),
                None => NewWindow::new()
                    .target_window(format!("{}:", workspace.name))
                    .start_directory(workspace.path.clone()),
            };

            Tmux::new().add_command(new_window).output().unwrap();
        }

        for (i, window) in workspace
            .windows
            .clone()
            .unwrap_or(vec![])
            .iter()
            .enumerate()
        {
            let window_index = i + 1;

            if let Some(window) = window {
                Tmux::new()
                    .add_command(
                        SendKeys::new()
                            .target_pane(format!("{}:{}.1", workspace.name, window_index))
                            .key(&format!("{} Enter", window.command)),
                    )
                    .output()
                    .unwrap();
            }
        }

        Tmux::new()
            .add_command(
                SwitchClient::new().target_session(format!("{}:1", workspace.name.clone())),
            )
            .output()
            .unwrap();

        std::process::exit(0);
    }

    let command = args.command.unwrap();

    match command {
        Commands::List { format, tag } => {
            let tags = tag;
            let format = format.unwrap_or("%n: \"%p\" %t".to_string());
            let re_name = Regex::new(r"%n").unwrap();
            let re_path = Regex::new(r"%p").unwrap();
            let re_tags = Regex::new(r"%t").unwrap();

            for workspace in workspaces {
                if let Some(tags) = &tags {
                    if !tags.iter().all(|tag| workspace.tags.contains(tag)) {
                        continue;
                    }
                }

                let output = re_name.replace_all(&format, workspace.name.as_str());
                let output = re_path.replace_all(&output, workspace.path.as_str());
                let output = re_tags.replace_all(&output, workspace.tags.join(","));
                println!("{}", output);
            }
        }
        Commands::Add { name, path, tag } => {
            let path = path.unwrap_or(std::env::current_dir().unwrap().display().to_string());
            if workspaces.iter().any(|w| w.name == name) {
                eprintln!("Workspace with name {} already exists", name);
                std::process::exit(1);
            }

            if workspaces.iter().any(|w| w.path == path) {
                eprintln!("Workspace with path {} already exists", path);
                std::process::exit(1);
            }

            let tags = tag;
            let workspace = Workspace {
                name,
                path,
                tags: tags.unwrap_or(vec![]),
                windows: None,
            };

            let mut workspaces = workspaces;
            workspaces.push(workspace);
            save_workspaces(workspaces).unwrap_or_else(|_| {
                eprintln!("Couldn't save to workspace file");
                std::process::exit(1);
            });
        }
        Commands::Remove { name } => {
            if !workspaces.iter().any(|w| w.name == name) {
                eprintln!("Workspace with name {} doesn't exists", name);
                std::process::exit(1);
            }

            let workspaces = workspaces.into_iter().filter(|w| w.name != name).collect();
            save_workspaces(workspaces).unwrap_or_else(|_| {
                eprintln!("Couldn't save to workspace file");
                std::process::exit(1);
            });
        }
        Commands::Path { name } => {
            let workspace = workspaces.iter().find(|w| w.name == name);
            match workspace {
                Some(workspace) => println!("{}", workspace.path),
                None => {
                    eprintln!("Workspace with name {} doesn't exists", name);
                    std::process::exit(1);
                }
            }
        }
        Commands::Config {} => println!("{}", get_config_file_path().display()),
    }
}

fn get_config_file_path() -> std::path::PathBuf {
    let current_dir = homedir::get_my_home().unwrap().unwrap();
    let path = current_dir.join(".config").join("workspaces.json");
    path
}

fn load_workspaces() -> Result<Vec<Workspace>, Box<dyn error::Error>> {
    let path = get_config_file_path();
    let file = File::open(path)?;
    let reader = BufReader::new(file);
    let workspaces: Vec<Workspace> = serde_json::from_reader(reader).unwrap_or_else(|_| {
        eprintln!("Couldn't parse workspace file, make sure it's valid JSON");
        std::process::exit(1);
    });

    Ok(workspaces)
}

fn save_workspaces(workspaces: Vec<Workspace>) -> Result<(), Box<dyn error::Error>> {
    let path = get_config_file_path();
    let file = File::create(path)?;
    serde_json::to_writer(file, &workspaces)?;

    Ok(())
}

#[derive(Debug, Clone, Deserialize, Serialize)]
struct Workspace {
    name: String,
    path: String,
    tags: Vec<String>,
    windows: Option<Vec<Option<Window>>>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
struct Window {
    name: Option<String>,
    command: String,
}
