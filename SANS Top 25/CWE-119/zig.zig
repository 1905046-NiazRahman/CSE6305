const std = @import("std");
pub fn main() void {
    var buf: [5]u8 = [_]u8{0} ** 5;
    const input: [8]u8 = [_]u8{ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H' };
    @memcpy(buf[0..], &input);  // No bounds check; overflows into adjacent memory
    std.debug.print("{any}\n", .{buf});
}
