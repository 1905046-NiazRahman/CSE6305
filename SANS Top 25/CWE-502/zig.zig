const std = @import("std");

const Malicious = struct {
    data: []u8,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const malicious_json = "{\"data\": [1,2,3,null,true,false]}";
    var parsed = try std.json.parseFromSlice(Malicious, allocator, malicious_json, .{});
    defer parsed.deinit();
    std.debug.print("Deserialized - vulnerable\n", .{});
}
