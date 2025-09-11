use crate::domain::{orientation::Orientation, position::Position};

pub fn parse_grid(line: &str) -> Option<(i32, i32)> {
    let mut it = line.split_whitespace();
    let x = it.next()?.parse().ok()?;
    let y = it.next()?.parse().ok()?;
    Some((x, y))
}

pub fn parse_robot(line: &str) -> Option<(Position, Orientation)> {
    let mut it = line.split_whitespace();
    let x: i32 = it.next()?.parse().ok()?;
    let y: i32 = it.next()?.parse().ok()?;
    let o = Orientation::parse(it.next()?)?;
    Some((Position { x, y }, o))
}

pub fn normalize_instr(line: &str) -> String {
    line.chars()
        .filter(|c| matches!(c, 'L' | 'R' | 'F'))
        .collect()
}
