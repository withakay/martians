const std = @import("std");

const Direction = enum {
    N,
    E,
    S,
    W,

    fn toChar(self: Direction) u8 {
        return switch (self) {
            .N => 'N',
            .E => 'E',
            .S => 'S',
            .W => 'W',
        };
    }

    fn fromChar(c: u8) Direction {
        return switch (c) {
            'N' => .N,
            'E' => .E,
            'S' => .S,
            'W' => .W,
            else => .N,
        };
    }

    fn turnLeft(self: Direction) Direction {
        return switch (self) {
            .N => .W,
            .W => .S,
            .S => .E,
            .E => .N,
        };
    }

    fn turnRight(self: Direction) Direction {
        return switch (self) {
            .N => .E,
            .E => .S,
            .S => .W,
            .W => .N,
        };
    }

    fn step(self: Direction) struct { x: i32, y: i32 } {
        return switch (self) {
            .N => .{ .x = 0, .y = 1 },
            .E => .{ .x = 1, .y = 0 },
            .S => .{ .x = 0, .y = -1 },
            .W => .{ .x = -1, .y = 0 },
        };
    }
};

const Scent = struct {
    x: i32,
    y: i32,
    d: Direction,
};

fn inside(x: i32, y: i32, mx: i32, my: i32) bool {
    return x >= 0 and x <= mx and y >= 0 and y <= my;
}

fn hasScent(scents: []const Scent, x: i32, y: i32, d: Direction) bool {
    for (scents) |scent| {
        if (scent.x == x and scent.y == y and scent.d == d) {
            return true;
        }
    }
    return false;
}

fn trim(s: []const u8) []const u8 {
    var start: usize = 0;
    var end: usize = s.len;

    while (start < s.len and (s[start] == ' ' or s[start] == '\t' or s[start] == '\r' or s[start] == '\n')) {
        start += 1;
    }

    while (end > start and (s[end - 1] == ' ' or s[end - 1] == '\t' or s[end - 1] == '\r' or s[end - 1] == '\n')) {
        end -= 1;
    }

    return s[start..end];
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var lines = std.ArrayList([]u8).init(allocator);
    defer {
        for (lines.items) |line| {
            allocator.free(line);
        }
        lines.deinit();
    }

    // Read all input
    var buf: [1024]u8 = undefined;
    while (try stdin.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const trimmed = trim(line);
        if (trimmed.len > 0) {
            const copy = try allocator.dupe(u8, trimmed);
            try lines.append(copy);
        }
    }

    if (lines.items.len == 0) {
        try std.io.getStdErr().writer().print("Empty input\n", .{});
        return;
    }

    // Parse grid size
    var it = std.mem.tokenize(u8, lines.items[0], " ");
    const mx = try std.fmt.parseInt(i32, it.next().?, 10);
    const my = try std.fmt.parseInt(i32, it.next().?, 10);

    var scents = std.ArrayList(Scent).init(allocator);
    defer scents.deinit();

    // Process robots
    var i: usize = 1;
    while (i + 1 < lines.items.len) : (i += 2) {
        // Parse initial position
        var pos_it = std.mem.tokenize(u8, lines.items[i], " ");
        var x = try std.fmt.parseInt(i32, pos_it.next().?, 10);
        var y = try std.fmt.parseInt(i32, pos_it.next().?, 10);
        var d = Direction.fromChar(pos_it.next().?[0]);

        // Process instructions
        const instructions = lines.items[i + 1];
        var lost = false;

        for (instructions) |c| {
            if (lost) break;

            switch (c) {
                'L' => d = d.turnLeft(),
                'R' => d = d.turnRight(),
                'F' => {
                    const delta = d.step();
                    const nx = x + delta.x;
                    const ny = y + delta.y;

                    if (!inside(nx, ny, mx, my)) {
                        if (!hasScent(scents.items, x, y, d)) {
                            try scents.append(.{ .x = x, .y = y, .d = d });
                            lost = true;
                        }
                    } else {
                        x = nx;
                        y = ny;
                    }
                },
                else => {},
            }
        }

        if (lost) {
            try stdout.print("{} {} {c} LOST\n", .{ x, y, d.toChar() });
        } else {
            try stdout.print("{} {} {c}\n", .{ x, y, d.toChar() });
        }
    }

    try stdout.print("\n", .{});
}
