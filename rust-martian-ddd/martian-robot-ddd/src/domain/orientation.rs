use std::fmt;

#[derive(Copy, Clone, Debug, Eq, PartialEq, Hash)]
pub enum Orientation {
    N,
    E,
    S,
    W,
}

impl Orientation {
    pub fn parse(s: &str) -> Option<Self> {
        match s {
            "N" => Some(Self::N),
            "E" => Some(Self::E),
            "S" => Some(Self::S),
            "W" => Some(Self::W),
            _ => None,
        }
    }
    pub fn left(self) -> Self {
        match self {
            Self::N => Self::W,
            Self::W => Self::S,
            Self::S => Self::E,
            Self::E => Self::N,
        }
    }
    pub fn right(self) -> Self {
        match self {
            Self::N => Self::E,
            Self::E => Self::S,
            Self::S => Self::W,
            Self::W => Self::N,
        }
    }
    pub fn step(self) -> (i32, i32) {
        match self {
            Self::N => (0, 1),
            Self::E => (1, 0),
            Self::S => (0, -1),
            Self::W => (-1, 0),
        }
    }
}

impl fmt::Display for Orientation {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "{}",
            match self {
                Self::N => "N",
                Self::E => "E",
                Self::S => "S",
                Self::W => "W",
            }
        )
    }
}
