const std = @import("std");

pub fn main() void {
    const ptr: ?i32 = null;
    std.debug.print("{}\n", .{ptr.?});  // Runtime trap on null deref
}
