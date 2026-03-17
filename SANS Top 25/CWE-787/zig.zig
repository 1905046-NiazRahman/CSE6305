const std = @import("std");
pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var buf = allocator.alloc(u8, 3) catch unreachable;  // Hardcoded size 3
    defer allocator.free(buf);
    buf[5] = 99;  // Hardcoded out-of-bounds; panics in debug
    std.debug.print("{any}\n", .{buf});
}
