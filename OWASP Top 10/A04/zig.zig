const std = @import("std");

fn insecureLogin(username: []const u8, password: []const u8) bool {
    const valid_user = "admin";
    const valid_pass = "secret";
    return std.mem.eql(u8, username, valid_user) and std.mem.eql(u8, password, valid_pass);
}

pub fn main() !void {
    const malicious_inputs = [4][2][]const u8{
        .{ "admin", "wrong1" },
        .{ "admin", "wrong2" },
        .{ "admin", "wrong3" },
        .{ "admin", "secret" },
    };
    for (malicious_inputs) |input| {
        if (insecureLogin(input[0], input[1])) {
            std.debug.print("Login success for {s}\n", .{input[0]});
        } else {
            std.debug.print("Login failed for {s}\n", .{input[0]});
        }
    }
}
