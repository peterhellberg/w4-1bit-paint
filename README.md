# w4-1bit-paint :paintbrush:

A pretty minimal paint program written in [Zig](https://ziglang.org/),
compiled into a `.wasm` cart for use in the
fantasy console [WASM-4](https://wasm4.org/).

:video_game: [Play](https://assets.c7.se/games/w4-1bit-paint/) or :package: [Download](https://assets.c7.se/games/w4-1bit-paint/w4-1bit-paint.zip)

## Usage

| Key        |                                             |
|-----------:|---------------------------------------------|
| **Z**      | Clear white
| **X**      | Clear black
| **M1**     | Color
| **M2**     | Toggle
| **M3**     | Toggle all
| **Arrows** | Switch “color” that is drawn with M1

## Development

File watcher can be started by calling:
```sh
zig build spy
```

Running the cart in WASM-4:
```sh
zig build run
```

Deploy:
```
make deploy
```
