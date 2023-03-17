pub trait Widget {
    fn render_content(&self) -> Result<String, Box<dyn std::error::Error>>;

    fn render_error(&self, _error: Box<dyn std::error::Error>) -> String {
        return String::from("Error");
    }

    fn render(&self, style: Style) -> String {
        let final_string = self.render_content();
        if let Err(error) = final_string {
            return self.render_error(error);
        }
        let final_string = final_string.unwrap();

        let final_string = match style.padding {
            None => final_string,
            Some(Padding::Left) => format!(" {}", final_string),
            Some(Padding::Right) => format!("{} ", final_string),
            Some(Padding::Both) => format!(" {} ", final_string),
        };

        let bg = style.tmux_color_code_bg.unwrap_or(String::from("default"));
        let fg = style.tmux_color_code_fg.unwrap_or(String::from("default"));

        format!("#[fg={},bg={}]{}", fg, bg, final_string)
    }
}

pub struct Style {
    pub tmux_color_code_bg: Option<String>,
    pub tmux_color_code_fg: Option<String>,
    pub padding: Option<Padding>,
}

pub enum Padding {
    Right,
    Left,
    Both,
}
