use super::{orientation::Orientation, position::Position};

pub trait ScentRepository {
    fn has_scent(&self, pos: Position, o: Orientation) -> bool;
    fn add_scent(&mut self, pos: Position, o: Orientation);
}
