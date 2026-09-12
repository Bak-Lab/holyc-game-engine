# HolyC Game Engine

HolyC Game Engine is a small, reusable 2D game library for
[HolyC Linux](https://github.com/Bak-Lab/holyc-linux). It provides the common
movement and collision behavior needed by native Linux games written in
HolyC.

The engine is intentionally compact and source-based. Games include
`HolyGame.HC`, then compile it alongside their own source through the HolyC
Linux `-I` option.

## Features

- Actors and axis-aligned rectangles
- Bounded game worlds
- Static rectangle walls
- Actor overlap tests
- Per-pixel swept movement that prevents tunneling
- Axis-separated collision response for natural wall sliding
- Move-toward and follower helpers
- Basic actor rendering through HolyC Linux graphics primitives

## Requirements

- HolyC Linux commit `f0199d3` or newer
- Clang
- SDL2 development files

## Build and test

Clone this repository beside `holyc-linux`:

```sh
git clone https://github.com/Bak-Lab/holyc-linux.git
git clone https://github.com/Bak-Lab/holyc-game-engine.git
cd holyc-linux
make compiler
cd ../holyc-game-engine
make test
```

To run the graphical movement example:

```sh
make
./build/slide-demo
```

## Use it in a game

Add the engine include to the HolyC source:

```c
#include "HolyGame.HC"
```

Then provide the include directory when compiling:

```sh
holyc Game.HC -I /path/to/holyc-game-engine/include -o build/game
```

Create a world, add walls, and move actors through it:

```c
HGWorld world;
HGActor player;

HGWorldInit(&world, 0, 0, 640, 480);
HGWorldAddWall(&world, 300, 40, 20, 300);
HGActorInit(&player, 40, 100, 12, 18);

HGMoveAndSlide(&player, move_x, move_y, &world);
```

`HGMoveAndSlide` resolves horizontal and vertical movement independently.
When diagonal movement reaches a wall, the blocked axis stops while the other
axis continues. Movement is applied one pixel at a time, so actors cannot jump
through thin walls at higher speeds.

## Scope

The first release focuses on deterministic movement and collision. Planned
areas include animation, scenes, tile maps, sprite helpers, audio, and
controller input. Features are added when a real game needs them.

## License

MIT
