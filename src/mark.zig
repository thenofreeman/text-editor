// mark.zig

const Location = @import("location");

const Mark = struct { // sorted
    next_mark: *Mark, // not circular
    id: i8,

    location: Location,
    is_fixed: bool,
};
