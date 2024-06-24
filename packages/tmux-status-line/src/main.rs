mod widgets;
use widgets::*;

use std::fs;

use tmux_status_line::Widget;

macro_rules! w {
    ($w:expr) => {
        Widget::new(Box::new($w))
    };
}

macro_rules! widgets {
    ($($ws:expr),+) => {
        let v = vec![
            $(
                $ws.display(),
            )+
        ];

        let widget_contents = v
            .into_iter()
            .filter(|v| v.is_some())
            .map(|v| v.unwrap())
            .collect::<Vec<String>>()
            .join("");

        print!("{}", widget_contents);
    };
}

enum Theme {
    Dark,
    Light,
}

fn get_color_scheme() -> Theme {
    let home = homedir::get_my_home().unwrap().unwrap();
    let alacrity_color_path = home.join(".config/alacritty/color.toml");
    let data = fs::read_to_string(alacrity_color_path)
        .ok()
        .unwrap_or("".to_string());
    let first_line = data.lines().next();

    if let Some(first_line) = first_line {
        if first_line == "# DARK" {
            return Theme::Dark;
        } else {
            return Theme::Light;
        }
    }

    return Theme::Dark;
}

enum Color {
    Red,
    Yellow,
    Orange,
    Green,
    Statusline1,
}

fn everforest_color(color: Color, theme: &Theme) -> &'static str {
    match color {
        Color::Red => match theme {
            Theme::Dark => "#e67e80",
            Theme::Light => "#f85552",
        },
        Color::Orange => match theme {
            Theme::Dark => "#e69875",
            Theme::Light => "#f57d26",
        },
        Color::Yellow => match theme {
            Theme::Dark => "#dbbc7f",
            Theme::Light => "#dfa000",
        },
        Color::Green => match theme {
            Theme::Dark => "#a7c080",
            Theme::Light => "#8da101",
        },
        Color::Statusline1 => match theme {
            Theme::Dark => "#a7c080",
            Theme::Light => "#93b259",
        },
    }
}

fn main() {
    let current_dir = homedir::get_my_home().ok().flatten().unwrap_or_else(|| {
        println!("Error: Could not get home directory");
        std::process::exit(1);
    });
    let path = current_dir.join(".harvest");
    let data = fs::read_to_string(path).ok();
    #[derive(serde::Deserialize)]
    struct Credentials {
        username: String,
        password: String,
    }
    let credentials = data
        .map(|d| serde_json::from_str::<Credentials>(&d).ok())
        .flatten();
    let username = credentials
        .as_ref()
        .map(|c| c.username.clone())
        .unwrap_or("".to_string());
    let password = credentials
        .as_ref()
        .map(|c| c.password.clone())
        .unwrap_or("".to_string());

    widgets![
        w!(HarvestWidget::new(username, password))
            .fg("#ffffff")
            .bg("#c74900")
            .max_width(50)
            .enabled(credentials.is_some()),
        w!(DiskWidget::new()),
        w!(TextWidget::from("|")).padding(false),
        w!(UptimeWidget::new()),
        w!(BatteryWidget::new()).fg("#000000").bg_func(|b| {
            let theme = get_color_scheme();

            match b.is_charging {
                true => everforest_color(Color::Yellow, &theme),
                false => {
                    if b.percentage <= 20 {
                        everforest_color(Color::Red, &theme)
                    } else {
                        everforest_color(Color::Statusline1, &theme)
                    }
                }
            }
            .to_string()
        }),
        w!(DateWidget::new_from_pattern("%a %H:%M %Y-%m-%d"))
    ];
}
