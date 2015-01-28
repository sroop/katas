require 'gosu'
require_relative 'cell.rb'
require_relative 'world.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize
    super 640, 480, false
    self.caption = "Game Of Life"
  end

end

GameOfLifeWindow.new.show