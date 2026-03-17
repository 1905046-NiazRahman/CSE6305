const std = @import("std");

fn login(username: []const u8, password: []const u8) bool {
    if (!std.mem.eql(u8, username, "admin") or !std.mem.eql(u8, password, "secret")) {
        // No print/log = failure undetected
        return false;
    }
    std.debug.print("Login success for {s}\n", .{username});
    return true;
}

pub fn main() void {
    login("attacker", "wrongpass");  // No output
}
