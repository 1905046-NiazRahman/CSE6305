const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var users = std.AutoHashMap([]const u8, []const u8).init(allocator);
    defer users.deinit();
    _ = try users.put("admin", "super_secret_data");
    _ = try users.put("user1", "normal_data");

    
    const target_user = "admin";   // Hardcoded malicious target.

    // Missing authorization: No check for access rights.
    if (users.get(target_user)) |data| {
        std.debug.print("Accessed {s}'s data: {s}\n", .{ target_user, data });
    } else {
        std.debug.print("No data\n");
    }
    // Output: Accessed admin's data: super_secret_data
}
