require 'gosu'
require_relative 'cell.rb'
require_relative 'world.rb'

class GameOfLifeWindow < Gosu::Window

  attr_accessor :width, :height
  attr_reader :rows, :cols, :world

  BACKGROUND_COLOUR = Gosu::Color.new(0xffdedede)
  LIVE_CELL_COLOUR = Gosu::Color.new(0xffff69b4)
  CELL_WIDTH, CELL_HEIGHT = 10, 10

  def initialize(width=640, height=480 )
    @width, @height = width, height
    super width, height, false
    self.caption = "Game Of Life"
    @rows, @cols = width/CELL_WIDTH, height/CELL_HEIGHT
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

    world.alive_cells.each do |cell|
      draw_quad(
                # Bottom left cell corner
                cell.x * CELL_WIDTH, cell.y * CELL_HEIGHT, LIVE_CELL_COLOUR,
                # Bottom right cell corner
                cell.x * CELL_WIDTH + CELL_WIDTH, cell.y * CELL_HEIGHT, LIVE_CELL_COLOUR,
                # Top right cell corner
                cell.x * CELL_WIDTH + CELL_WIDTH, cell.y * CELL_HEIGHT + CELL_HEIGHT, LIVE_CELL_COLOUR,
                # Top left cell corner
                cell.x * CELL_WIDTH, cell.y * CELL_HEIGHT + CELL_HEIGHT, LIVE_CELL_COLOUR,
                )
    end
  end

end

GameOfLifeWindow.new.show