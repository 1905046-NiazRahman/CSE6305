// Requires build.zig.zon + sqlite dependency
const std = @import("std");
const sqlite = @import("sqlite");

pub fn main() void {
    var db = sqlite.Database.open("test.db", .{}) catch unreachable;
    defer db.deinit();
    const username = "admin'; DROP TABLE users; --";
    _ = db.prepare("SELECT * FROM users WHERE username = ?1 AND active = ?1", &.{username}) catch unreachable;
    // Bind prevents injection
}
