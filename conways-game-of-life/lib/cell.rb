class Cell

  attr_accessor :world, :x, :y, :state

  def initialize(world, x=0, y=0)
    @world, @x, @y = world, x, y
    @state = "dead"
    @neighbours = []
  end

  def alive_neighbours
    neighbours.select(&:alive?)
  end

  def die!
    @state = "dead"
  end

  def life!
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

  def neighbours
    if @neighbours.empty?
      @neighbours << world.cell_at_coordinate(self.x - 1, self.y - 1)
      @neighbours << world.cell_at_coordinate(self.x, self.y - 1)
      @neighbours << world.cell_at_coordinate(self.x + 1, self.y - 1)

      @neighbours << world.cell_at_coordinate(self.x - 1, self.y)
      @neighbours << world.cell_at_coordinate(self.x + 1, self.y)

      @neighbours << world.cell_at_coordinate(self.x - 1, self.y + 1)
      @neighbours << world.cell_at_coordinate(self.x, self.y + 1)
      @neighbours << world.cell_at_coordinate(self.x + 1, self.y + 1)

      @neighbours.compact!
    end
    @neighbours
  end

end