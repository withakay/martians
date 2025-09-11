import java.util.*;

final class InMemoryScents implements ScentRepository {
    private final Set<String> set = new HashSet<>();

    public boolean has(Position p, Orientation o) {
        return set.contains(p.x + "," + p.y + "," + o);
    }

    public void add(Position p, Orientation o) {
        set.add(p.x + "," + p.y + "," + o);
    }
}
