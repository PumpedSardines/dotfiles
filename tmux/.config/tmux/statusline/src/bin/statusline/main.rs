use harvest::widget::Widget as HarvestWidget;
use widget::battery::BatteryWidget;
use widget::misc::*;
use widget::spotify::SpotifyWidget;
use widget::widget::Widget;

macro_rules! widget {
    ($w:expr) => {
        Widget::new(Box::new($w))
    };
}

fn main() {
    let widget_contents = vec![
        widget!(SpotifyWidget::new())
            .fg("#ffffff")
            .bg("#125724")
            .max_width(50)
            .display(),
        widget!(HarvestWidget::new())
            .fg("#ffffff")
            .bg("#c74900")
            .max_width(50)
            .display(),
        widget!(UptimeWidget::new()).display(),
        widget!(BatteryWidget::new())
            .fg("#000000")
            .bg_func(|b| {
                match b.is_charging {
                    true => "#ffee00",
                    false => "#51c449",
                }
                .to_string()
            })
            .display(),
        widget!(DateWidget::new_from_pattern("%a %H:%M %Y-%m-%d")).display(),
    ]
    .into_iter()
    .filter(|v| v.is_some())
    .map(|v| v.unwrap())
    .collect::<Vec<String>>()
    .join("");

    print!("{}", widget_contents);
}
