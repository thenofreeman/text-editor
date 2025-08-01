// mode.zig

const Mode = struct {
    next_mode: Mode, // not circular, in order of invocation
    name: *const []u8,

    addProcedure: fn () bool,
};
