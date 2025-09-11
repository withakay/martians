import java.io.*;
import java.util.*;

public class Main {
    static String readNonEmpty(BufferedReader br) throws IOException {
        String s;
        while ((s = br.readLine()) != null) {
            s = s.trim();
            if (!s.isEmpty())
                return s;
        }
        return null;
    }

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String header = readNonEmpty(br);
        if (header == null) {
            System.out.print("\n");
            return;
        }
        int[] g = Parsing.grid(header);
        Grid grid = new Grid(g[0], g[1]);
        ScentRepository scents = new InMemoryScents();
        StringBuilder out = new StringBuilder();
        while (true) {
            String meta = readNonEmpty(br);
            if (meta == null)
                break;
            Object[] rr = Parsing.robot(meta);
            Position pos = (Position) rr[0];
            Orientation o = (Orientation) rr[1];
            String instr = readNonEmpty(br);
            if (instr == null)
                instr = "";
            instr = Parsing.norm(instr);
            Robot robot = new Robot(pos, o);
            Navigator.execute(scents, grid, robot, instr);
            out.append(robot.position.x).append(' ').append(robot.position.y).append(' ').append(robot.orientation)
                    .append(robot.lost ? " LOST" : "").append('\n');
        }
        out.append('\n');
        System.out.print(out.toString());
    }
}
