use std::{error::Error, fmt};

#[derive(Debug)]
pub struct UptimeWidgetError;
impl fmt::Display for UptimeWidgetError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Address is localhost")
    }
}
impl Error for UptimeWidgetError {}

pub struct UptimeWidget<'a> {
    pattern: &'a str,
}
impl<'a> UptimeWidget<'a> {
    pub fn new() -> UptimeWidget<'a> {
        UptimeWidget { pattern: "%H:%M" }
    }
}
impl<'a> super::widget::Widget for UptimeWidget<'a> {
    fn render_content(&self) -> Result<String, Box<dyn std::error::Error>> {
        let uptime = uptime_lib::get()?;

        let minutes = uptime.as_secs_f64() / 60.0;
        if minutes < 60.0 {
            return Ok(format!("{} minutes", minutes.round()));
        }

        let hours = minutes / 60.0;
        if hours < 24.0 {
            return Ok(format!("{} hours", hours.round()));
        }

        let days = hours / 24.0;

        Ok(format!("{} days", days.round()))
    }
}
