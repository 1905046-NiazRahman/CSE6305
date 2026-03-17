const std = @import("std");

const User = struct {
    id: i32,
    data: []const u8,
};

fn getUserData(users: []const User, user_id: i32) ?[]const u8 {
    // Vulnerable: Always returns index 1 (admin)
    _=user_id;
    return users[1].data;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    _=allocator;
    const users = [_]User{
        .{ .id = 1, .data = "User data" },
        .{ .id = 2, .data = "Admin secrets" },
    };
    if (getUserData(&users, 1)) |data| {
        std.debug.print("{s}\n", .{data});  // Outputs: Admin secrets
    }
}
