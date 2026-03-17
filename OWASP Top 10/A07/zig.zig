const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    var sessions = std.StringHashMap([]const u8).init(allocator);
    defer sessions.deinit();
    
    // Hardcoded malicious session ID from attacker
    const attacker_session = "fixed_attacker_session123";
    
    // Simulate login: accepts fixed session without validation
    try sessions.put(attacker_session, "attacker_user");
    
    // No compiler/runtime check - vuln exposed
    std.debug.print("Zig: Session fixed to '{s}', no built-in protection.\n", .{attacker_session});
}
