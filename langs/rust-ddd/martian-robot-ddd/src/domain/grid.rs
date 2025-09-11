use super::position::Position;

#[derive(Copy, Clone, Debug)]
pub struct Grid {
    pub max_x: i32,
    pub max_y: i32,
}

impl Grid {
    pub fn new(max_x: i32, max_y: i32) -> Self {
        Self { max_x, max_y }
    }
    pub fn contains(&self, p: Position) -> bool {
        0 <= p.x && p.x <= self.max_x && 0 <= p.y && p.y <= self.max_y
    }
}
