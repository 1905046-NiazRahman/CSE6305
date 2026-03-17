const std = @import("std");
pub fn main() !void {
    const malicious_input = "<script>alert('XSS')</script>";
    const response = std.fmt.allocPrint(std.heap.page_allocator, "Welcome, user: {s}", .{malicious_input}) catch unreachable;
    defer std.heap.page_allocator.free(response);
    std.debug.print("{s}\n", .{response});  // Outputs raw payload
}
