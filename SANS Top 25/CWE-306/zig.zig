const std = @import("std");

pub fn main() void {
    // No auth check
    
    const deleteUserDatabase = struct {
        fn func() void {
            std.debug.print("Database deleted! Critical function executed without auth.\n", .{});
        }
    }.func;
    
    deleteUserDatabase();  // Executes freely
}
