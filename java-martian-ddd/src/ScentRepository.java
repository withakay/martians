interface ScentRepository {
    boolean has(Position p, Orientation o);

    void add(Position p, Orientation o);
}
