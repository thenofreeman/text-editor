// buffer.zig

const std = @import("std");

// const CircularList = @import("util").CircularList;

const Location = @import("location").Location;
const Mode = @import("mode").Mode;
const Mark = @import("mark").Mark;
const Storage = @import("storage").Storage;

pub const Buffer = struct {
    next_buffer: *Buffer, // circular list
    buffer_name: *const []u8,
    buffer_id: u8,

    point: Location,

    char_count: i32,
    line_count: i32,
    cur_index: i32,

    mark_list: *Mark,

    contents: *Storage,

    file_name: *const []u8,
    sync_time: *std.time, // last time file and buffer were identical
    is_modified: bool,

    mode_list: *Mode,

    const Self = @This();

    pub fn init(name: *const []u8) Buffer {
        return Buffer{
            // .next_buffer = ?
            .buffer_name = name,

            // ...

        };
    }
};
