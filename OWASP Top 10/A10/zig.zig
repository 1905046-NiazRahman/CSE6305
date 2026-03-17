const std = @import("std");
const http = std.http;
const net = std.net;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const malicious_url = "http://169.254.169.254/latest/meta-data/";  // Hardcoded SSRF payload
    var client = http.Client{ .allocator = allocator };
    defer client.deinit();

    var req = try client.open(.GET, malicious_url, .{ .version = .@"1.1" }, .{});
    defer req.deinit();

    try req.send(.{});
    try req.wait();

    const body = try req.reader().readAllAlloc(allocator, 1024 * 1024);
    defer allocator.free(body);
    std.debug.print("SSRF Response: {s}\n", .{body});  // Succeeds, no protection
}
