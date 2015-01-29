class Cell

  attr_accessor :world, :x, :y, :state
  attr_reader :neighbours

  def initialize(world, x=0, y=0)
    @world = world
    @x = x
    @y = y
    world.cells << self
    world.dead_cells << self
    @state = "dead"
    @neighbours = []
  end

  def alive_neighbours
    @alive_neighbours = []
    neighbours.each do |cell|
      @alive_neighbours << cell if cell.alive?
    end
    @alive_neighbours
  end

  def assign_neighbours
    world.cells.each do |cell|
      (-1..1).each do |x|
        (-1..1).each do |y|
          if ([self.x, self.y] == [cell.x + x, cell.y + y]) && ([x,y] != [0,0])
            @neighbours << cell
          end
        end
      end
    end
  end

  def die!
    world.dead_cells << self
    world.alive_cells -= [self]
    @state = "dead"
  end

  def life!
    world.alive_cells << self
    world.dead_cells -= [self]
    @state = "alive"
  end

  def dead?
    @state == "dead"
  end

  def alive?
    @state == "alive"
  end

  def spawn_at_coordinate(x, y)
    Cell.new(world, x, y)
  end

end