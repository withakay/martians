use crate::domain::{orientation::Orientation, position::Position, scents::ScentRepository};
use std::collections::HashSet;

#[derive(Default)]
pub struct InMemoryScents {
    set: HashSet<(i32, i32, Orientation)>,
}

impl ScentRepository for InMemoryScents {
    fn has_scent(&self, pos: Position, o: Orientation) -> bool {
        self.set.contains(&(pos.x, pos.y, o))
    }
    fn add_scent(&mut self, pos: Position, o: Orientation) {
        self.set.insert((pos.x, pos.y, o));
    }
}
