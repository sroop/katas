class Cell

  attr_accessor :world, :x, :y

  def initialize(world, x=0, y=0)
    @world = world
    @x = x
    @y = y
    world.cells << self
  end

  def neighbours
    []
  end

  def spawn_at_coordinate(x, y)
    Cell.new(world, x, y)
  end

end