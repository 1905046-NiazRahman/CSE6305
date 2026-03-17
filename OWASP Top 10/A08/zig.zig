const std = @import("std");

const User = struct {
    role: [32]u8,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    _=allocator;
    // Hardcoded "legit" bytes for user role="user\0..."
    var legit_bytes = [_]u8{ 0, 0, 0, 0, 0, 0, 0, 4, 'u', 's', 'e', 'r', 0, 0, 0 };
    
    // Tamper: overwrite to "admin"
    legit_bytes[8..13].* = [_]u8{ 'a', 'd', 'm', 'i', 'n' };
    
    var stream = std.io.fixedBufferStream(&legit_bytes);
    var reader = stream.reader();
    var malicious: User = undefined;
    // Simulate simple deserialization (byte copy)
    _ = try reader.readAll(std.mem.asBytes(&malicious));
    
    std.debug.print("Role: s\n", .{malicious.role[0..5]});
    // Outputs "admin" - exploit succeeds
}
