mod battery_widget;
use battery_widget::BatteryWidget;

mod uptime_widget;
use uptime_widget::UptimeWidget;

mod date_widget;
use date_widget::DateWidget;

use crate::widget::Widget;
mod widget;

fn main() {
    let battery_widget = BatteryWidget::new();
    let battery_widget_contents = battery_widget.render(widget::Style {
        tmux_color_code_bg: Some("#125724".to_string()),
        tmux_color_code_fg: Some("#ffffff".to_string()),
        padding: Some(widget::Padding::Both),
    });

    let uptime_widget = UptimeWidget::new();
    let uptime_widget_contents = uptime_widget.render(widget::Style {
        tmux_color_code_bg: None,
        tmux_color_code_fg: None,
        padding: Some(widget::Padding::Both),
    });

    let date_widget = DateWidget::new_from_pattern("%a %H:%M %Y-%m-%d");
    let date_widget_contents = date_widget.render(widget::Style {
        tmux_color_code_bg: None,
        tmux_color_code_fg: None,
        padding: Some(widget::Padding::Right),
    });

    print!(
        "{}{}{}",
        battery_widget_contents, uptime_widget_contents, date_widget_contents
    );
}
