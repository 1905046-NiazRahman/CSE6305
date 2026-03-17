const std = @import("std");
pub fn main() void {
    var arr = [_]u8{ 1, 2, 3, 4, 5 };
    const idx: usize = 10;  // Hardcoded malicious
    std.debug.print("{}\n", .{arr[idx]});  // Panic in Debug: index 10 >= 5
}
