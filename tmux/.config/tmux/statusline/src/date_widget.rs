use chrono;
use std::{error::Error, fmt};

#[derive(Debug)]
pub struct DateWidgetError;
impl fmt::Display for DateWidgetError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Address is localhost")
    }
}
impl Error for DateWidgetError {}

pub struct DateWidget<'a> {
    pattern: &'a str,
}
impl<'a> DateWidget<'a> {
    pub fn new() -> DateWidget<'a> {
        DateWidget { pattern: "%H:%M" }
    }

    pub fn new_from_pattern(pattern: &'a str) -> DateWidget<'a> {
        DateWidget { pattern }
    }
}
impl<'a> super::widget::Widget for DateWidget<'a> {
    fn render_content(&self) -> Result<String, Box<dyn std::error::Error>> {
        let now = chrono::Local::now().naive_local();

        Ok(now.format(self.pattern).to_string())
    }
}
