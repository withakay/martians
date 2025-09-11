final class Robot {
    Position position;
    Orientation orientation;
    boolean lost = false;

    Robot(Position p, Orientation o) {
        this.position = p;
        this.orientation = o;
    }

    void turnLeft() {
        orientation = orientation.left();
    }

    void turnRight() {
        orientation = orientation.right();
    }

    Position nextForward() {
        return switch (orientation) {
            case N -> new Position(position.x, position.y + 1);
            case E -> new Position(position.x + 1, position.y);
            case S -> new Position(position.x, position.y - 1);
            case W -> new Position(position.x - 1, position.y);
        };
    }
}
