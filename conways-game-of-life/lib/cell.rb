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

  def north_edge?
    world.cells.last.include?(self)
  end

  def east_edge?
    world.cells.select { |row| row.last == self }.any?
  end

  def south_edge?
    world.cells.first.include?(self)
  end

  def west_edge?
    world.cells.select { |row| row.first == self }.any?
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

      if east_edge?
        @neighbours << world.cell_at_coordinate(0, self.y)
        @neighbours << world.cell_at_coordinate(0, self.y + 1)
        @neighbours << world.cell_at_coordinate(0, self.y - 1)
      end

      if north_edge?
        @neighbours << world.cell_at_coordinate(self.x, 0)
        @neighbours << world.cell_at_coordinate(self.x + 1, 0)
        @neighbours << world.cell_at_coordinate(self.x - 1, 0)
      end

      @neighbours << world.cell_at_coordinate(0, 0) if north_edge? && east_edge?

      @neighbours.compact!
    end
    @neighbours
  end

end