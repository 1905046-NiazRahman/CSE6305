const std = @import("std");
pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var array = std.ArrayList(u8).init(allocator);
    defer array.deinit();
    const malicious_size: u64 = 1_000_000_000;  // Hardcoded huge
    for (0..malicious_size) |_| {
        _ = array.append('a') catch break;  // No auto-limit
    }
    std.debug.print("Allocated {d} bytes\n", .{array.items.len});
}
