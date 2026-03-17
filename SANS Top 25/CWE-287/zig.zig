const std = @import("std");

fn authenticate(username: []const u8, _password: []const u8) bool {
    _ = _password;
    return std.mem.eql(u8, username, "admin");  // Ignores password
}

pub fn main() !void {
    const invalid = authenticate("admin", "wrongpass");  // Hardcoded malicious
    std.debug.print("Invalid login: {}\n", .{invalid});  // true
}
