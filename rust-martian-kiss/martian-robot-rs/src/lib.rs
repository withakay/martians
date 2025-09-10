use std::collections::HashSet;
use std::str::FromStr;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

impl Direction {
    pub fn turn_left(self) -> Self {
        use Direction::*;
        match self {
            North => West,
            West => South,
            South => East,
            East => North,
        }
    }
    pub fn turn_right(self) -> Self {
        use Direction::*;
        match self {
            North => East,
            East => South,
            South => West,
            West => North,
        }
    }
    pub fn delta(self) -> (i32, i32) {
        use Direction::*;
        match self {
            North => (0, 1),
            East => (1, 0),
            South => (0, -1),
            West => (-1, 0),
        }
    }
}

impl TryFrom<char> for Direction {
    type Error = String;
    fn try_from(c: char) -> Result<Self, Self::Error> {
        match c {
            'N' => Ok(Direction::North),
            'E' => Ok(Direction::East),
            'S' => Ok(Direction::South),
            'W' => Ok(Direction::West),
            _ => Err(format!("invalid direction: {c}")),
        }
    }
}

impl From<Direction> for char {
    fn from(d: Direction) -> char {
        match d {
            Direction::North => 'N',
            Direction::East => 'E',
            Direction::South => 'S',
            Direction::West => 'W',
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Position {
    pub x: i32,
    pub y: i32,
    pub heading: Direction,
}

#[derive(Debug, Clone)]
pub struct Grid {
    pub max_x: i32,
    pub max_y: i32,
}

impl Grid {
    pub fn contains(&self, x: i32, y: i32) -> bool {
        x >= 0 && y >= 0 && x <= self.max_x && y <= self.max_y
    }
}

#[derive(Debug, Clone)]
pub struct Robot {
    pub pos: Position,
    pub lost: bool,
}

impl Robot {
    pub fn apply(
        &mut self,
        grid: &Grid,
        scents: &mut HashSet<(i32, i32, Direction)>,
        instruction: Instruction,
    ) {
        if self.lost {
            return;
        }
        match instruction {
            Instruction::Left => self.pos.heading = self.pos.heading.turn_left(),
            Instruction::Right => self.pos.heading = self.pos.heading.turn_right(),
            Instruction::Forward => {
                let (dx, dy) = self.pos.heading.delta();
                let nx = self.pos.x + dx;
                let ny = self.pos.y + dy;
                if !grid.contains(nx, ny) {
                    let scent = (self.pos.x, self.pos.y, self.pos.heading);
                    if !scents.contains(&scent) {
                        scents.insert(scent);
                        self.lost = true;
                    }
                } else {
                    self.pos.x = nx;
                    self.pos.y = ny;
                }
            }
        }
    }
}

#[derive(Debug, Clone, Copy)]
pub enum Instruction {
    Left,
    Right,
    Forward,
}

impl TryFrom<char> for Instruction {
    type Error = String;
    fn try_from(c: char) -> Result<Self, Self::Error> {
        match c {
            'L' => Ok(Instruction::Left),
            'R' => Ok(Instruction::Right),
            'F' => Ok(Instruction::Forward),
            _ => Err(format!("invalid instruction: {c}")),
        }
    }
}

impl Instruction {
    fn from_char(c: char) -> Option<Self> {
        match c {
            'L' => Some(Instruction::Left),
            'R' => Some(Instruction::Right),
            'F' => Some(Instruction::Forward),
            _ => None,
        }
    }
}

#[derive(Debug, Clone)]
pub struct Scenario {
    pub grid: Grid,
    pub robots: Vec<(Robot, Vec<Instruction>)>,
}

impl FromStr for Scenario {
    type Err = String;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let mut lines = s.lines().filter(|l| !l.trim().is_empty());
        let first = lines.next().ok_or("missing grid line")?;
        let mut sp = first.split_whitespace();
        let max_x: i32 = sp
            .next()
            .ok_or("grid max_x")?
            .parse()
            .map_err(|_| "bad max_x")?;
        let max_y: i32 = sp
            .next()
            .ok_or("grid max_y")?
            .parse()
            .map_err(|_| "bad max_y")?;
        let grid = Grid { max_x, max_y };

        let mut robots = Vec::new();
        while let Some(pos_line) = lines.next() {
            let cmds = lines
                .next()
                .ok_or("missing instructions line")?
                .trim()
                .to_string();
            let mut p = pos_line.split_whitespace();
            let x: i32 = p.next().ok_or("x")?.parse().map_err(|_| "bad x")?;
            let y: i32 = p.next().ok_or("y")?.parse().map_err(|_| "bad y")?;
            let dch = p.next().ok_or("dir")?.chars().next().ok_or("empty dir")?;
            let heading = Direction::try_from(dch)?;
            let robot = Robot {
                pos: Position { x, y, heading },
                lost: false,
            };
            let instructions = cmds
                .chars()
                .filter_map(Instruction::from_char)
                .collect::<Vec<_>>();
            robots.push((robot, instructions));
        }
        Ok(Scenario { grid, robots })
    }
}

pub fn run_scenario(scenario: &Scenario) -> Vec<String> {
    let mut scents: HashSet<(i32, i32, Direction)> = HashSet::new();
    let mut outs = Vec::new();
    for (mut robot, instructions) in scenario.robots.clone() {
        for instr in instructions {
            robot.apply(&scenario.grid, &mut scents, instr);
            if robot.lost {
                break;
            }
        }
        let heading_char: char = robot.pos.heading.into();
        let line = if robot.lost {
            format!("{} {} {} LOST", robot.pos.x, robot.pos.y, heading_char)
        } else {
            format!("{} {} {}", robot.pos.x, robot.pos.y, heading_char)
        };
        outs.push(line);
    }
    outs
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn sample() {
        let input = "\
5 3
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL
";
        let scenario: Scenario = input.parse().unwrap();
        let outs = run_scenario(&scenario);
        let expected = ["1 1 E", "3 3 N LOST", "2 3 S"];
        assert_eq!(outs, expected);
    }
}
