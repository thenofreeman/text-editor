// world.zig

const Buffer = @import("buffer").Buffer;
const Location = @import("location").Location;

const World = struct {
    buffer_chain: *Buffer,
    active_buffer: *Buffer,

    initialized: bool,

    const Self = @This();

    pub fn init(self: Self) bool {
        self.buffer_chain = Buffer.init("--SCRATCH--");
        self.active_buffer = self.buffer_chain;

        self.initialized = true;

        return true;
    }

    pub fn close(self: Self) bool {
        if (!self.initialized) {
            // loop through all buffers and remove all but --SCRATCH--

            return false;
        }

        return true;
    }

    pub fn save(self: Self) bool {
        // save editor specific state to file

        _ = self;
    }

    pub fn load(self: Self) bool {
        // load editor specific state from file

        _ = self;
    }

    // Buffer
    pub fn createBuffer(name: *const []u8) bool {}

    pub fn clearBuffer(name: *const []u8) bool {} // removes all characters and marks

    pub fn deleteBuffer(name: *const []u8) bool {}

    pub fn setCurrentBuffer(name: *const []u8) bool {}

    pub fn nextBuffer(self: Self) *const []u8 {
        self.active_buffer = self.active_buffer.next_buffer;

        return self.getBufferName();
    }

    pub fn setBufferName(self: Self, name: *const []u8) bool {
        // check if name exists already

        self.active_buffer.buffer_name = name;

        return true;
    }

    pub fn getBufferName(self: Self) *const []u8 {
        return self.active_buffer.buffer_name;
    }

    // Point
    pub fn setPoint(location: Location) bool {}
    pub fn movePoint(n: i32) bool {} // if possible
    pub fn getCurrentPoint() Location {} // current location
    pub fn getCurrentLine() i32 {}
    pub fn getStartPoint() Location {} // point at start of buffer
    pub fn getEndPoint() Location {} // point at end of buffer

    // Location Utilities
    pub fn compareLocations(a: Location, b: Location) i32 {} // -1 if a before b
    pub fn locationToCount(location: Location) i32 {} // n chars between start and location
    pub fn countToLocation(count: i32) Location {} // converts an absolute pos and returns a point

    // Mark
    pub fn createMark(id: i8, fixed: bool) bool {}
    pub fn deleteMark(id: i8) bool {}
    pub fn getMark(id: i8) Location {}
    pub fn setMark(id: i8, location: Location) bool {}

    // Mark Utilities
    pub fn compareMarkWithPoint(id: i8) i32 {} // -1 if mark before point
    pub fn setMarkToPoint(id: i8) bool {}
    pub fn setPointToMark(id: i8) bool {}
    pub fn swapMarkWithPoint(id: i8) bool {}

    // Buffer Info
    pub fn getCharAtPoint() i8 {} // returns char AFTER point
    pub fn getStringAtPoint(n: i8) *const []u8 {}
    pub fn getCharCount() i32 {}
    pub fn getLineCount() i32 {}

    // File Operations
    pub fn getFileName() *const []u8 {}
    pub fn setFileName(name: *const []u8) bool {}
    pub fn writeBuffer() bool {} // do internal-external representation conversions, update file time, clear mod flag
    pub fn readBuffer() bool {} // do external-internal representation conversions, update file time, clear mod flag
    pub fn insertIntoBuffer(str: *const []u8) bool {}
    pub fn fileHasChanged() bool {}
    pub fn setModified(modified: bool) void {}
    pub fn getModified() bool {}

    // Multi-Mode
    pub fn appendMode(name: *const []u8, addProcedure: fn () bool, front: bool) bool {} // front adds to the start, else end
    pub fn deleteMode(name: *const []u8) bool {}
    pub fn invokeModes() bool {} // invoke add proc on mode list to create cmd set

    // Buffer Modifications (all set mod flag)
    pub fn insertChar(c: []u8) void {}
    pub fn insertString(str: *const []u8) void {}
    pub fn replaceChar(c: []u8) void {}
    pub fn replaceString(str: *const []u8) void {}
    pub fn deleteChars(n: i32) bool {}
    pub fn deleteToMark(name: *const []u8) bool {}
    pub fn copyToMark(mark_name: *const []u8, buffer_name: *const []u8) *const []u8 {}

    // Search and Match
    pub fn forwardSearch(query: *const []u8) bool {}
    pub fn backwardSearch(query: *const []u8) bool {}
    pub fn hasSearchMatch(query: *const []u8) bool {}
    pub fn findFirstForward(query: *const []u8) bool {}
    pub fn findFirstBackward(query: *const []u8) bool {}
    pub fn findFirstNotForward(query: *const []u8) bool {}
    pub fn findFirstNotBackward(query: *const []u8) bool {}

    // Columns
    pub fn getColumn() i32 {}
    pub fn setColumn(column: i32, round: bool) void {}
};
