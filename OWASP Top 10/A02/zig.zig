const std = @import("std");

const KEY = "secretkey";

fn xorEncryptDecrypt(data: []u8) void {
    const key_bytes = KEY.*;
    for (data, 0..) |*byte, i| {  // Explicit range provides index without conflict
        byte.* ^= key_bytes[i % key_bytes.len];
    }
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const text = "password123";
    const buf = try allocator.dupe(u8, text);
    defer allocator.free(buf);

    xorEncryptDecrypt(buf);     
    std.debug.print("Obfuscated: {s}\n", .{buf});
    xorEncryptDecrypt(buf);     
    std.debug.print("Decrypted: {s}\n", .{buf});
}
