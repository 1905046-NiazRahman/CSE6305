const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const base = "./uploads";
    const user_input = "../../etc/passwd";  // Hardcoded malicious
    const path = try std.fmt.allocPrint(allocator, "{s}/{s}", .{ base, user_input });
    defer allocator.free(path);
    
    const file = std.fs.cwd().openFile(path, .{}) catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    defer file.close();
    std.debug.print("Opened: {s}\n", .{path});
}
