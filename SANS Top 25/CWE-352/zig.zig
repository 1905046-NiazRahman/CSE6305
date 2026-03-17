const std = @import("std");

const Transfer = struct { to: []const u8, amount: u32 };

fn transferFunds(allocator: std.mem.Allocator) !void {
    // Duplicate string literal to own the memory
    const to = try allocator.dupe(u8, "attacker_account");
    defer allocator.free(to);
    
    var forged = Transfer{ .to = to, .amount = 1000 };
    std.debug.print("Transferred {d} to {s}\n", .{ forged.amount, forged.to });
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    try transferFunds(gpa.allocator());
}
