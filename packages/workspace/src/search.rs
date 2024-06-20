use skim::prelude::*;
use std::io::Cursor;

pub fn search(items: Vec<String>) -> Option<String> {
    let options = SkimOptionsBuilder::default().build().unwrap();

    let input = items.join("\n");

    let item_reader = SkimItemReader::default();
    let items = item_reader.of_bufread(Cursor::new(input));

    let selected_items = Skim::run_with(&options, Some(items))
        .map(|out| match out.is_abort {
            true => None,
            false => Some(out.selected_items),
        })
        .flatten()
        .unwrap_or_else(|| Vec::new());

    if selected_items.is_empty() {
        return None;
    }

    let selected_item = selected_items[0].output();
    Some(selected_item.to_string())
}
