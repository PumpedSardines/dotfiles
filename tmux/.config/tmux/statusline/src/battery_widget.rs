use battery::units::ratio::percent;
use battery::{Battery, Manager};
use std::{error::Error, fmt};

#[derive(Debug)]
pub struct NoBatteryError;
impl fmt::Display for NoBatteryError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Address is localhost")
    }
}
impl Error for NoBatteryError {}
pub fn get_battery() -> Result<Battery, Box<dyn Error>> {
    for battery in Manager::new()?.batteries()? {
        if let Ok(battery) = battery {
            return Ok(battery);
        }
    }

    Err(NoBatteryError.into())
}

#[derive(Debug)]
pub struct BatteryWidgetError;
impl fmt::Display for BatteryWidgetError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Address is localhost")
    }
}
impl Error for BatteryWidgetError {}

pub struct BatteryWidget;
impl BatteryWidget {
    pub fn new() -> BatteryWidget {
        BatteryWidget {}
    }
}
impl super::widget::Widget for BatteryWidget {
    fn render_content(&self) -> Result<String, Box<dyn std::error::Error>> {
        let battery = get_battery()?;

        let is_charging = battery.time_to_full().is_some();
        let percentage = battery.state_of_charge().get::<percent>();

        let mut battery_text = format!("{}%", percentage.round());

        if is_charging {
            battery_text = format!("{} {}", "\u{f0e7}", battery_text);
        }

        Ok(battery_text)
    }
}
