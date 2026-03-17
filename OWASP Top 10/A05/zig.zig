const std = @import("std");
const net = std.net;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var listener = try net.StreamServer.init(.{});
    defer listener.deinit();
    try listener.listen(net.Address.parseIp4("127.0.0.1", 8080) catch unreachable);

    while (true) {
        var conn = try listener.accept();
        _ = try handleConn(allocator, conn.stream);
    }
}

fn handleConn(allocator: std.mem.Allocator, stream: net.Stream) !void {
    var buffer: [1024]u8 = undefined;
    const recv = try stream.readAll(buffer[0..]);
    _=recv;
    // Hardcoded malicious input
    const malicious = "1/0";
    var it = std.mem.split(u8, malicious, "/");
    const a = try std.fmt.parseInt(i32, it.next() orelse "0", 10);
    const b = try std.fmt.parseInt(i32, it.next() orelse "1", 10);
    const result = a / b;  // Runtime integer overflow/trap if zero
    
    const response = try std.fmt.allocPrint(allocator, "Result: {}", .{result});
    defer allocator.free(response);
    _ = try stream.writeAll(response);
}
