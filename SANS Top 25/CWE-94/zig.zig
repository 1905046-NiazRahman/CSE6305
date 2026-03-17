const std = @import("std");
pub fn main() !void {
    const input = "ls; cat /etc/passwd";  // Hardcoded malicious input
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var child = std.process.Child.init(&[_][]const u8{"sh", "-c", input}, allocator);
    child.exec() catch |err| std.debug.print("Error: {}\n", .{err});
}
