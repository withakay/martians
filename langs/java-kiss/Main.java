import java.io.*;
import java.util.*;

public class Main {
    static boolean inside(int x, int y, int mx, int my) {
        return 0 <= x && x <= mx && 0 <= y && y <= my;
    }

    static int[] step(char d) {
        switch (d) {
            case 'N':
                return new int[] { 0, 1 };
            case 'E':
                return new int[] { 1, 0 };
            case 'S':
                return new int[] { 0, -1 };
            case 'W':
                return new int[] { -1, 0 };
            default:
                return new int[] { 0, 0 };
        }
    }

    static char left(char d) {
        switch (d) {
            case 'N':
                return 'W';
            case 'W':
                return 'S';
            case 'S':
                return 'E';
            case 'E':
                return 'N';
            default:
                return d;
        }
    }

    static char right(char d) {
        switch (d) {
            case 'N':
                return 'E';
            case 'E':
                return 'S';
            case 'S':
                return 'W';
            case 'W':
                return 'N';
            default:
                return d;
        }
    }

    public static void main(String[] args) throws Exception {
        String data;
        try (BufferedReader br = new BufferedReader(new InputStreamReader(System.in))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null)
                sb.append(line).append('\n');
            data = sb.toString();
        }
        if (data.trim().isEmpty()) {
            System.err.println("No input provided");
            System.exit(1);
        }
        List<String> lines = new ArrayList<>();
        for (String ln : data.split("\n")) {
            ln = ln.trim();
            if (!ln.isEmpty())
                lines.add(ln);
        }
        if (lines.isEmpty()) {
            System.err.println("Empty input");
            System.exit(1);
        }
        String[] head = lines.get(0).split("\\s+");
        if (head.length < 2) {
            System.err.println("Invalid header");
            System.exit(1);
        }
        int mx = Integer.parseInt(head[0]);
        int my = Integer.parseInt(head[1]);
        Set<String> scents = new HashSet<>();
        StringBuilder out = new StringBuilder();
        for (int i = 1; i + 1 < lines.size(); i += 2) {
            String[] p = lines.get(i).split("\\s+");
            int x = Integer.parseInt(p[0]), y = Integer.parseInt(p[1]);
            char d = p[2].charAt(0);
            String instr = lines.get(i + 1);
            boolean lost = false;
            for (int k = 0; k < instr.length() && !lost; k++) {
                char c = instr.charAt(k);
                if (c == 'L')
                    d = left(d);
                else if (c == 'R')
                    d = right(d);
                else if (c == 'F') {
                    int[] s = step(d);
                    int nx = x + s[0], ny = y + s[1];
                    if (!inside(nx, ny, mx, my)) {
                        String key = x + "," + y + "," + d;
                        if (scents.contains(key))
                            continue;
                        scents.add(key);
                        lost = true;
                    } else {
                        x = nx;
                        y = ny;
                    }
                } // else ignore unknown
            }
            out.append(x).append(' ').append(y).append(' ').append(d).append(lost ? " LOST" : "").append('\n');
        }
        System.out.print(out.toString());
        System.out.println();
    }
}
