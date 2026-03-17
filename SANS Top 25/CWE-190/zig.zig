const std = @import("std");
pub fn main() void {
    const a: i32 = 2_000_000_000;
    const b: i32 = 2_000_000_000;
    const sum: i32 = a + b;  // Debug: traps; ReleaseFast: wraps
    std.debug.print("Sum: {}\n", .{sum});  // Debug: traps with safety dump
}
