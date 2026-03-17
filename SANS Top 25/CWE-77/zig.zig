const std = @import("std");
pub fn main() void {
    const input = "; rm -rf /";  // Separate arg
    var argv = [_][]const u8{ "ls", input };
    var child = std.process.Child.init(&argv, std.heap.page_allocator);
    _ = child.spawnAndWait() catch unreachable;
}
