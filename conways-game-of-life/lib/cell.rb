class Cell

  attr_accessor :world, :x, :y

  def initialize(world, x=0, y=0)
    @world = world
    @x = x
    @y = y
    world.cells << self
    world.alive_cells << self
  end

  def neighbours
    @neighbours = []
    world.alive_cells.each do |cell|
      unless self.equal?(cell)
        (-1..1).each do |x|
          (-1..1).each do |y|
            if [self.x, self.y] == [cell.x + x, cell.y + y]
              @neighbours << cell
            end
          end
        end
      end
    end
    @neighbours
  end

  def die!
    world.dead_cells << self
    world.alive_cells -= [self]
  end

  def life!
    world.alive_cells << self
    world.dead_cells -= [self]
  end

  def dead?
    world.dead_cells.include?(self)
  end

  def alive?
    world.alive_cells.include?(self)
  end

  def spawn_at_coordinate(x, y)
    Cell.new(world, x, y)
  end

end