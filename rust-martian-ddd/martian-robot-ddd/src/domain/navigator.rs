use super::{grid::Grid, robot::Robot, scents::ScentRepository};

pub fn execute<R: ScentRepository>(
    repo: &mut R,
    grid: &Grid,
    robot: &mut Robot,
    instructions: &str,
) {
    for ch in instructions.chars() {
        if robot.lost {
            break;
        }
        match ch {
            'L' => robot.turn_left(),
            'R' => robot.turn_right(),
            'F' => {
                let next = robot.next_forward();
                if !grid.contains(next) {
                    if !repo.has_scent(robot.position, robot.orientation) {
                        repo.add_scent(robot.position, robot.orientation);
                        robot.lost = true;
                    }
                } else {
                    robot.position = next;
                }
            }
            _ => {}
        }
    }
}
