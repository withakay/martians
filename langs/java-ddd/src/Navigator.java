final class Navigator {
    static void execute(ScentRepository scents, Grid grid, Robot robot, String instr) {
        for (int i = 0; i < instr.length() && !robot.lost; i++) {
            char c = instr.charAt(i);
            if (c == 'L')
                robot.turnLeft();
            else if (c == 'R')
                robot.turnRight();
            else if (c == 'F') {
                Position next = robot.nextForward();
                if (!grid.contains(next)) {
                    if (!scents.has(robot.position, robot.orientation)) {
                        scents.add(robot.position, robot.orientation);
                        robot.lost = true;
                    }
                } else {
                    robot.position = next;
                }
            }
        }
    }
}
