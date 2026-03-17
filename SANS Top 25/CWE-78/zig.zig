const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Simulated malicious input
    const malicious = "somefile; echo MALICIOUS && touch /tmp/hacked_zig";

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Vulnerable pattern: invoking shell with -c and concatenating untrusted input
    const full_cmd = try std.fmt.allocPrint(allocator, "ls {s}", .{malicious});
    defer allocator.free(full_cmd);

    try stdout.print("About to run: {s}\n", .{full_cmd});

    var child = std.ChildProcess.init(
        &[_][]const u8{ "/bin/sh", "-c", full_cmd },
        allocator,
    );
    defer child.deinit();

    child.stdout_behavior = .Pipe;
    try child.spawn();

    if (child.stdout) |stdout_pipe| {
        var buf_reader = std.io.bufferedReader(stdout_pipe.reader());
        const reader = buf_reader.reader();
        var buf: [1024]u8 = undefined;

        while (true) {
            const n = try reader.read(&buf);
            if (n == 0) break;
            try stdout.writeAll(buf[0..n]);
        }
    }

    const term = try child.wait();
    try stdout.print("\nExit: {}\n", .{term});
}
