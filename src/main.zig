const std = @import("std");
const openslide = @import("openslide.zig");
// const c = @cImport({
//     @cInclude("openslide.h");
// });

pub fn abc() void {
    // OpenSlide 라이브러리를 사용하여 이미지 파일 열기
    // const filename = "path/to/your/image.svs";
    const filename = "/Users/kjmin/Downloads/DB-001-00002.svs";
    const slide: ?*openslide.openslide_t = openslide.openslide_open(filename);

    if (openslide.openslide_get_error(slide) != null) {
        std.debug.print("Error opening slide: {s}\n", .{openslide.openslide_get_error(slide)});
        return;
    }

    // 슬라이드의 레벨 가져오기
    const level_count: i64 = openslide.openslide_get_level_count(slide);
    std.debug.print("Number of levels: {d}\n", .{level_count});

    // 레벨 0의 너비와 높이 가져오기
    var width: i64 = 0;
    var height: i64 = 0;
    openslide.openslide_get_level_dimensions(slide, 0, &width, &height);
    std.debug.print("Level 0 dimensions: {d}x{d}\n", .{ width, height });

    // 슬라이드 닫기
    openslide.openslide_close(slide);
}
pub fn main() !void {
    abc();
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
