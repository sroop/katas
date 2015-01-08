class Cell

  attr_accessor :world, :x, :y

  def initialize(world, x=0, y=0)
    @world = world
    @x = x
    @y = y
    world.cells << self
  end

  def neighbours
    @neighbours = []
    world.cells.each do |cell|
      if self.x == cell.x && self.y == (cell.y - 1)
        @neighbours << cell
      elsif self.x && (cell.x - 1) && self.y == (cell.y - 1)
        @neighbours << cell
      end
    end
    @neighbours
  end

  def spawn_at_coordinate(x, y)
    Cell.new(world, x, y)
  end

end