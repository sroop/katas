Conways Game of Life
============

Description
----
Implementing [Conways Game of Life] in Ruby using Gosu gaming library to produce the visual output.

Rules
---
* Any live cell with fewer than two live neighbours dies, as if caused by under-population.
* Any live cell with two or three live neighbours lives on to the next generation.
* Any live cell with more than three live neighbours dies, as if by overcrowding.
* Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

How to run it
----

```sh
git clone git@github.com:sroop/katas.git
cd katas/conways-game-of-life
bundle install
ruby './lib/game_of_life_board.rb'
```

Note: You may need to follow these pre-requisites in the [Gosu documentation] before bundling if you don't have Gosu already installed on your machine.

How to test it
----

```sh
git clone git@github.com:sroop/katas.git
cd katas/conways-game-of-life
bundle install
bundle exec rspec
```

[Conways Game of Life]:http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
[Gosu documentation]:https://github.com/jlnr/gosu/wiki/Getting-Started-on-OS-X
