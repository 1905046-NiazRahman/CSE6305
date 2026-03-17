const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var client = std.http.Client{ .allocator = allocator };

    // Benign request
    const benign_uri = try std.Uri.parse("https://example.com/");
    var benign_req = try client.open(.GET, benign_uri, .{});
    defer benign_req.deinit();
    try benign_req.send(.{});
    var benign_resp = try benign_req.wait();
    std.debug.print("Benign status: {}\n", .{benign_resp.status});

    // Malicious SSRF to internal metadata (no protection)
    const malicious_uri = try std.Uri.parse("http://169.254.169.254/latest/meta-data/");
    var ssrf_req = try client.open(.GET, malicious_uri, .{});
    defer ssrf_req.deinit();
    try ssrf_req.send(.{});
    var ssrf_resp = try ssrf_req.wait();
    std.debug.print("SSRF status: {}\n", .{ssrf_resp.status});
}
