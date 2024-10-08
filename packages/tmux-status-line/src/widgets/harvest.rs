use tmux_status_line::Cache;
use tmux_status_line::WidgetRenderer;

pub struct HarvestWidget {
    username: String,
    password: String,
}
impl HarvestWidget {
    pub fn new(username: String, password: String) -> Self {
        HarvestWidget { username, password }
    }
}

impl WidgetRenderer<Option<harvest::RunningTimerInfo>> for HarvestWidget {
    fn get_data(&self) -> Result<Option<harvest::RunningTimerInfo>, Box<dyn std::error::Error>> {
        let api = harvest::Api::new(&self.username, &self.password);

        let cache = Cache::new("harvest", 20);

        let data = cache.load::<harvest::RunningTimerInfo>();

        if let Some(data) = data {
            return Ok(Some(data));
        }

        let resp: Option<harvest::RunningTimerInfo> = api.running_timer().ok().flatten();

        if let Some(resp) = resp.clone() {
            cache.save(resp);
        }

        Ok(resp)
    }

    fn render_content(&self, value: Option<harvest::RunningTimerInfo>) -> Option<String> {
        if let Some(data) = value {
            return Some(match data.notes {
                None => format!("\u{f017}  {} - {}", data.hours, data.project),
                Some(notes) => format!("\u{f017}  {} - {} - {}", data.hours, notes, data.project),
            });
        }

        None
    }
}
