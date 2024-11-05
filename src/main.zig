const c = @cImport({
    // See https://github.com/ziglang/zig/issues/515
    @cInclude("stdio.h");
});

pub fn main() void {
    const x: c_int = 7;

    _ = c.printf("Hello, world! %d\n", x);
}
