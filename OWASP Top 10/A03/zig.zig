const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const user_input = "ping 127.0.0.1; whoami";  // Hardcoded malicious payload
    var child = std.process.Child.init(&[_][]const u8{ "sh", "-c", user_input }, allocator);  // Vulnerable concat
    child.spawn() catch |err| {
        std.debug.print("Spawn error: {}\n", .{err});
        return;
    };
    _ = try child.wait();
}
