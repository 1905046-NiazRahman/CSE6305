const std = @import("std");

pub fn main() !void {
    const path = "target.txt";
    try std.fs.cwd().writeFile(path, "initial");

    const t1 = try std.Thread.spawn(.{}, struct {
        fn work(file_path: []const u8) void {  // Renamed from 'path'
            std.time.sleep(50 * std.time.ns_per_ms);
            const content = std.fs.cwd().readFileAlloc(std.heap.page_allocator, file_path, 1024) catch return;
            defer std.heap.page_allocator.free(content);
            if (std.mem.eql(u8, content, "initial")) {
                std.fs.cwd().writeFile(file_path, "raced_by_t1") catch return;
                std.debug.print("T1 wrote after check\n", .{});
            }
        }
    }.work, .{path});

    const t2 = try std.Thread.spawn(.{}, struct {
        fn work(file_path: []const u8) void {  // Renamed from 'path'
            const content = std.fs.cwd().readFileAlloc(std.heap.page_allocator, file_path, 1024) catch return;
            defer std.heap.page_allocator.free(content);
            if (std.mem.eql(u8, content, "initial")) {
                std.fs.cwd().writeFile(file_path, "raced_by_t2") catch return;
                std.debug.print("T2 wrote after check\n", .{});
            }
        }
    }.work, .{path});

    t1.join();
    t2.join();

    const final = try std.fs.cwd().readFileAlloc(std.heap.page_allocator, path, 1024);
    defer std.heap.page_allocator.free(final);
    std.debug.print("Final: {s}\n", .{final});
}
