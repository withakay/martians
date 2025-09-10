final class Parsing {
    static int[] grid(String line) {
        String[] p = line.trim().split("\\s+");
        return new int[] { Integer.parseInt(p[0]), Integer.parseInt(p[1]) };
    }

    static Object[] robot(String line) {
        String[] p = line.trim().split("\\s+");
        return new Object[] { new Position(Integer.parseInt(p[0]), Integer.parseInt(p[1])), Orientation.valueOf(p[2]) };
    }

    static String norm(String line) {
        return line.trim().replaceAll("[^LRF]", "");
    }
}
