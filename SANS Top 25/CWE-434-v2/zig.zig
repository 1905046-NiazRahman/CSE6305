const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    
    if (args.len != 3) {
        std.debug.print("Usage: {s} <input> <output.txt>\n", .{args[0]});
        return;
    }
    
    // Safe commented payload
    const payload = "# ASPX Template - No executable code\n<!-- <% Response.Write(Request[\"cmd\"]) %> -->";
    
    var input = try std.fs.cwd().openFile(args[1], .{});
    defer input.close();
    
    var output = try std.fs.cwd().createFile(args[2], .{});
    defer output.close();
    
    // Direct copy - NO validation
    try input.copyToFile(output, .{});
    try output.writer().print("{s}", .{payload});
    
    std.debug.print(" CWE-434: {s} created\n", .{args[2]});
}
