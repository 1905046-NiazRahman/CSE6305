const std = @import("std");

fn processLen(ally: std.mem.Allocator, input: []const u8) !void {
    const len = try std.fmt.parseInt(u64, input, 10);
    const buf = try ally.alloc(u8, len); // Fails if oversized.
    defer ally.free(buf);
    std.debug.print("Processed length: {}\n", .{len});
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const malicious = "18446744073709551620"; // Overflow risk.
    try processLen(gpa.allocator(), malicious); // Manual test: Runtime allocator error/panic.
}
