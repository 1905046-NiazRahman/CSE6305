const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const file = try std.fs.cwd().createFile("secret.txt", .{});
    defer file.close();
    try file.writer().print("sensitive data\n", .{});
    // Implicit 0666 perms
}
