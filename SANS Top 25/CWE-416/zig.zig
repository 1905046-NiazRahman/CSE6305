const std = @import("std");

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    const ptr = try allocator.create(i32);
    ptr.* = 42;
    allocator.destroy(ptr);  // Frees memory
    std.debug.print("{}\n", .{ptr.*});  // UAF: use after free
}
