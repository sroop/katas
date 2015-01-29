class World

  attr_accessor :cells, :alive_cells, :dead_cells, :rows, :cols

  def initialize(rows=3,cols=3)
    @cells = []
    @alive_cells = []
    @dead_cells = []
    @rows,@cols = rows,cols
  end

  def seed
    master_cell = cells.first
    (master_cell.x...rows).each do |x|
      (master_cell.x...cols).each do |y|
        master_cell.spawn_at_coordinate(x,y) unless [x,y] == [master_cell.x, master_cell.y]
      end
    end
    cells.each do |cell|
      cell.assign_neighbours
    end
  end

  def tick!
    cells.each do | cell |
      if cell.alive_neighbours.count < 2 || cell.alive_neighbours.count > 3
        cell.die! if cell.alive?
      elsif cell.alive_neighbours.count == 3
        cell.life! if cell.dead?
      end
    end
  end

  def populate
    cells.each do |cell|
      [alive_cells, dead_cells].sample << cell
    end
  end

end