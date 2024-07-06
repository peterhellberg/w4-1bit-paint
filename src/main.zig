const w4 = @import("w4");

const Stride = 40;
const Size = w4.SCREEN_SIZE / Stride;
const Color = enum { black, dark, light, white };

const App = struct {
    mouse: w4.Mouse = .{},
    button: w4.Button = .{},

    color: Color = .black,
    squares: [1600]Color = .{.white} ** 1600,

    fn start(_: *App) void {
        w4.palette(.{ 0, 0xFFFFFF, 0, 0 });
    }

    fn update(self: *App) void {
        self.mouse.update();
        self.button.update();

        if (self.button.released(0, w4.BUTTON_1)) self.setAll(.black);
        if (self.button.released(0, w4.BUTTON_2)) self.setAll(.white);
        if (self.button.released(0, w4.BUTTON_UP)) self.color = .white;
        if (self.button.released(0, w4.BUTTON_LEFT)) self.color = .light;
        if (self.button.released(0, w4.BUTTON_DOWN)) self.color = .dark;
        if (self.button.released(0, w4.BUTTON_RIGHT)) self.color = .black;
        if (self.mouse.released(w4.MOUSE_MIDDLE)) self.toggleAll();
        if (self.mouseInBounds()) {
            if (self.mouse.held(w4.MOUSE_LEFT)) self.set(self.color);
            if (self.mouse.released(w4.MOUSE_RIGHT)) self.toggle();
        }
    }

    fn mouseInBounds(self: *App) bool {
        const m = self.mouse;

        return !(m.x < 1 or m.x > 159 or m.y < 1 or m.y > 159);
    }

    fn toggle(self: *App) void {
        self.set(switch (self.get()) {
            .white => .black,
            .black => .white,
            .dark => .light,
            .light => .dark,
        });
    }

    fn toggleAll(self: *App) void {
        for (0.., self.squares) |i, s| {
            self.squares[i] = switch (s) {
                .white => .black,
                .black => .white,
                .dark => .light,
                .light => .dark,
            };
        }
    }

    fn setAll(self: *App, state: Color) void {
        self.squares = .{state} ** 1600;
    }

    fn set(self: *App, state: Color) void {
        const m = self.mouse;
        const sx = @divTrunc(m.x - @mod(m.x, 4), Size);
        const sy = @divTrunc(m.y - @mod(m.y, 4), Size);
        const i: usize = @intCast(sy * Stride + sx);

        self.squares[i] = state;
    }

    fn get(self: *App) Color {
        const m = self.mouse;
        const sx = @divTrunc(m.x - @mod(m.x, 4), Size);
        const sy = @divTrunc(m.y - @mod(m.y, 4), Size);
        const i: usize = @intCast(sy * Stride + sx);

        return self.squares[i];
    }

    fn draw(self: *App) void {
        for (0.., self.squares) |i, s| {
            const n: i32 = @intCast(i);
            const x: i32 = @mod(n, Stride);
            const y: i32 = @divTrunc(n, Stride);

            w4.color(switch (s) {
                .black => 0x11,
                .dark => 0x12,
                .light => 0x21,
                .white => 0x22,
            });

            w4.rect(x * Size, y * Size, Size, Size);
        }
    }
};

var app = App{};

export fn start() void {
    app.start();
}

export fn update() void {
    app.update();
    app.draw();
}
