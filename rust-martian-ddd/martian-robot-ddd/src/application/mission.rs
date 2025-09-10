use crate::application::{in_memory_scents::InMemoryScents, parsing};
use crate::domain::navigator::execute;
use crate::domain::{grid::Grid, orientation::Orientation, robot::Robot};
use std::io::{BufRead, Write};

fn read_non_empty<R: BufRead>(r: &mut R, buf: &mut String) -> Option<String> {
    buf.clear();
    loop {
        let n = r.read_line(buf).ok()?;
        if n == 0 {
            return None;
        }
        let s = buf.trim();
        if !s.is_empty() {
            return Some(s.to_string());
        }
        buf.clear();
    }
}

pub fn run<R: BufRead, W: Write>(reader: &mut R, mut writer: W) -> std::io::Result<()> {
    let mut buf = String::new();
    let header = match read_non_empty(reader, &mut buf) {
        Some(s) => s,
        None => return Ok(()),
    };
    let (mx, my) = parsing::parse_grid(&header).expect("invalid grid header");
    let grid = Grid::new(mx, my);
    let mut scents = InMemoryScents::default();

    while let Some(meta) = read_non_empty(reader, &mut buf) {
        let (pos, o) = parsing::parse_robot(&meta).expect("invalid robot meta");
        let instr = read_non_empty(reader, &mut buf).unwrap_or_default();
        let instr = parsing::normalize_instr(&instr);

        let mut robot = Robot::new(pos, o);
        execute(&mut scents, &grid, &mut robot, &instr);

        writeln!(
            writer,
            "{} {} {}{}",
            robot.position.x,
            robot.position.y,
            orientation_to_str(robot.orientation),
            if robot.lost { " LOST" } else { "" }
        )?;
    }
    // trailing blank line to match goldens
    writeln!(writer)?;
    Ok(())
}

fn orientation_to_str(o: Orientation) -> &'static str {
    match o {
        Orientation::N => "N",
        Orientation::E => "E",
        Orientation::S => "S",
        Orientation::W => "W",
    }
}
