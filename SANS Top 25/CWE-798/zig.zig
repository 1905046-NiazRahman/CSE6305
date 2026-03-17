const std = @import("std");

pub fn main() void {
    const hardcoded_user: []const u8 = "admin";
    const hardcoded_pass: []const u8 = "secret123";  // Hard-coded credential

    if (std.mem.eql(u8, hardcoded_user, "admin") and
        std.mem.eql(u8, hardcoded_pass, "secret123")) {
        std.debug.print("Login successful!\n", .{});  // Vulnerable: creds exposed
    }
}
