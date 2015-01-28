require 'gosu'
require_relative 'cell.rb'
require_relative 'world.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize(width=640, height=480 )
    super @width=width, @height=height, false
    self.caption = "Game Of Life"
    @bg_colour = Gosu::Color.new(0xffdedede)

    @world = World.new(@width/10, @height/10)
    @cell = Cell.new(@world)
    @world.seed
    @world.populate
  end

  def draw
    draw_quad(0,0,@bg_colour,
              @width,0,@bg_colour,
              @width,@height,@bg_colour,
              0,@height,@bg_colour)
  end

end

GameOfLifeWindow.new.show