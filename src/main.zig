const std = @import("std");

const Status = bool;
const Location = i32;
const Storage = *const []u8;

const Mode = struct {
    next_mode: Mode, // not circular, in order of invocation
    name: *const []u8,

    // pub fn add() Status {}
    addProcedure: fn () Status,
};

const Mark = struct { // sorted
    next_mark: *Mark, // not circular
    id: i8,

    location: Location,
    is_fixed: bool,
};

const Buffer = struct {
    next_buffer: *Buffer, // circular list
    buffer_name: *const []u8,

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
};

const World = struct {
    buffer_chain: *Buffer,
    active_buffer: Buffer,
};

const Editor = struct {
    world: World,

    // World
    pub fn initWorld() Status {} // creates scratch buffer
    pub fn closeWorld() Status {} // cannot be called until after init()
    pub fn saveWorld() Status {} // saves all state to a file
    pub fn loadWorld() Status {} // loads all state to a file

    // Buffer
    pub fn createBuffer(name: *const []u8) Status {}
    pub fn clearBuffer(name: *const []u8) Status {} // removes all characters and marks
    pub fn deleteBuffer(name: *const []u8) Status {}
    pub fn setCurrentBuffer(name: *const []u8) Status {}
    pub fn nextBuffer() *const []u8 {}
    pub fn setBufferName(name: *const []u8) Status {}
    pub fn getBufferName() *const []u8 {}

    // Point
    pub fn setPoint(location: Location) Status {}
    pub fn movePoint(n: i32) Status {} // if possible
    pub fn getCurrentPoint() Location {} // current location
    pub fn getCurrentLine() i32 {}
    pub fn getStartPoint() Location {} // point at start of buffer
    pub fn getEndPoint() Location {} // point at end of buffer

    // Location Utilities
    pub fn compareLocations(a: Location, b: Location) i32 {} // -1 if a before b
    pub fn locationToCount(location: Location) i32 {} // n chars between start and location
    pub fn countToLocation(count: i32) Location {} // converts an absolute pos and returns a point

    // Mark
    pub fn createMark(id: i8, fixed: bool) Status {}
    pub fn deleteMark(id: i8) Status {}
    pub fn getMark(id: i8) Location {}
    pub fn setMark(id: i8, location: Location) Status {}

    // Mark Utilities
    pub fn compareMarkWithPoint(id: i8) i32 {} // -1 if mark before point
    pub fn setMarkToPoint(id: i8) Status {}
    pub fn setPointToMark(id: i8) Status {}
    pub fn swapMarkWithPoint(id: i8) Status {}

    // Buffer Info
    pub fn getCharAtPoint() i8 {} // returns char AFTER point
    pub fn getStringAtPoint(n: i8) *const []u8 {}
    pub fn getCharCount() i32 {}
    pub fn getLineCount() i32 {}

    // File Operations
    pub fn getFileName() *const []u8 {}
    pub fn setFileName(name: *const []u8) Status {}
    pub fn writeBuffer() Status {} // do internal-external representation conversions, update file time, clear mod flag
    pub fn readBuffer() Status {} // do external-internal representation conversions, update file time, clear mod flag
    pub fn insertIntoBuffer(str: *const []u8) Status {}
    pub fn fileHasChanged() bool {}
    pub fn setModified(modified: bool) void {}
    pub fn getModified() bool {}

    // Multi-Mode
    pub fn appendMode(name: *const []u8, addProcedure: fn () Status, front: bool) Status {} // front adds to the start, else end
    pub fn deleteMode(name: *const []u8) Status {}
    pub fn invokeModes() Status {} // invoke add proc on mode list to create cmd set

    // Buffer Modifications (all set mod flag)
    pub fn insertChar(c: []u8) void {}
    pub fn insertString(str: *const []u8) void {}
    pub fn replaceChar(c: []u8) void {}
    pub fn replaceString(str: *const []u8) void {}
    pub fn deleteChars(n: i32) Status {}
    pub fn deleteToMark(name: *const []u8) Status {}
    pub fn copyToMark(mark_name: *const []u8, buffer_name: *const []u8) *const []u8 {}

    // Search and Match
    pub fn forwardSearch(query: *const []u8) Status {}
    pub fn backwardSearch(query: *const []u8) Status {}
    pub fn hasSearchMatch(query: *const []u8) bool {}
    pub fn findFirstForward(query: *const []u8) Status {}
    pub fn findFirstBackward(query: *const []u8) Status {}
    pub fn findFirstNotForward(query: *const []u8) Status {}
    pub fn findFirstNotBackward(query: *const []u8) Status {}

    // Columns
    pub fn getColumn() i32 {}
    pub fn setColumn(column: i32, round: bool) void {}
};

pub fn main() !void {}
