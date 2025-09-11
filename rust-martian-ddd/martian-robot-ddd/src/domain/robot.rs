use super::{orientation::Orientation, position::Position};

#[derive(Copy, Clone, Debug)]
pub struct Robot {
    pub position: Position,
    pub orientation: Orientation,
    pub lost: bool,
}

impl Robot {
    pub fn new(position: Position, orientation: Orientation) -> Self {
        Self {
            position,
            orientation,
            lost: false,
        }
    }
    pub fn turn_left(&mut self) {
        self.orientation = self.orientation.left();
    }
    pub fn turn_right(&mut self) {
        self.orientation = self.orientation.right();
    }
    pub fn next_forward(&self) -> Position {
        let (dx, dy) = self.orientation.step();
        Position {
            x: self.position.x + dx,
            y: self.position.y + dy,
        }
    }
}
