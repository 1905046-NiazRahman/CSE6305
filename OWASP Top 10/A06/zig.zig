const std = @import("std");
const json = @import("vulnerable_json.zig").Parser; // Assume outdated manual dep with RCE flaw

pub fn main() void {
    const evil_json = "{\"rce\": \"system('calc.exe')\"}"; // Hardcoded malicious input
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var parsed = json.parse(allocator, evil_json) catch @panic("Parse fail"); // Triggers vuln
    std.debug.print("Executed: {s}\n", .{parsed.rce}); // Runtime: exploits if vuln dep
}
