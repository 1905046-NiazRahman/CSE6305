const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    
    if (args.len != 3) {
        std.debug.print("Usage: {s} <input.jpg> <shell.config>\n", .{args[0]});
        return;
    }
    
    const marker = "[CWE-434-DEMO]";
    
    var input = try std.fs.cwd().openFile(args[1], .{});
    defer input.close();
    
    var output = try std.fs.cwd().createFile(args[2], .{});
    defer output.close();
    
    // NO TYPE CHECKING - direct copy to dangerous extension
    try input.copyToFile(output, .{});
    try output.writer().print("\n{s}\n", .{marker});
    
    std.debug.print("✅ CWE-434: {s} created\n", .{args[2]});
}
