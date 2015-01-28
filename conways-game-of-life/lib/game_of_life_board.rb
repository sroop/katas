require 'gosu'
require_relative 'cell.rb'
require_relative 'world.rb'

class GameOfLifeWindow < Gosu::Window

  attr_accessor :width, :height

  BACKGROUND_COLOUR = Gosu::Color.new(0xffdedede)

  def initialize(width=640, height=480 )
    @width, @height = width, height
    super width, height, false
    self.caption = "Game Of Life"
    create_world
  end

  def create_world
    @world = World.new(rows, cols)
    Cell.new(world)
    world.seed
    world.populate
  end

  def needs_cursor?
    true
  end

  def draw
    draw_quad(0, 0, BACKGROUND_COLOUR,
              width, 0, BACKGROUND_COLOUR,
              width, height, BACKGROUND_COLOUR,
              0, height, BACKGROUND_COLOUR)
  end

end

GameOfLifeWindow.new.show