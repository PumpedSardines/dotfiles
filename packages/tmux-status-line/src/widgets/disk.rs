use std::path::Path;
use std::{error::Error, fmt};
use sysinfo::{Disks, System};
use tmux_status_line::WidgetRenderer;

struct HumanReadableSize(f64, String);
impl HumanReadableSize {
    fn size(&self) -> f64 {
        self.0
    }
    fn unit(&self) -> &str {
        &self.1
    }
}

fn to_human_readable(bytes: u64) -> HumanReadableSize {
    let units = ["B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"];
    let mut size = bytes as f64;
    let mut i = 0;
    while size > 1024.0 {
        size /= 1024.0;
        i += 1;
    }
    HumanReadableSize(size, units[i].to_string())
}

#[derive(Debug)]
pub struct DiskError;
impl fmt::Display for DiskError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Disk error")
    }
}
impl Error for DiskError {}

pub struct DiskData {
    total: u64,
    available: u64,
    ram_total: u64,
    ram_used: u64,
}

// TODO: Add error handling
pub fn get_disk() -> Result<DiskData, Box<dyn Error>> {
    let mut sys = System::new_all();
    sys.refresh_all();

    let disks = Disks::new_with_refreshed_list();

    let disk = disks
        .list()
        .into_iter()
        .find(|d| d.mount_point() == Path::new("/"))
        .ok_or(DiskError)?;

    let total = disk.total_space();
    let available = disk.available_space();

    Ok(DiskData {
        total,
        available,
        ram_total: sys.total_memory(),
        ram_used: sys.used_memory(),
    })
}

pub struct DiskWidget {}
impl DiskWidget {
    pub fn new() -> DiskWidget {
        DiskWidget {}
    }
}
impl WidgetRenderer<DiskData> for DiskWidget {
    fn get_data(&self) -> Result<DiskData, Box<dyn std::error::Error>> {
        get_disk()
    }

    fn render_content(&self, value: DiskData) -> Option<String> {
        let total = value.total;
        let available = value.available;
        let used = total - available;
        let percentage = (used as f64 / total as f64 * 100.0) as usize;

        let available = to_human_readable(available);

        Some(format!(
            "{:.2}% {:.2}{}",
            percentage,
            available.size(),
            available.unit()
        ))
    }
}
