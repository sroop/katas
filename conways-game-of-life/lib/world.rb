class World

  attr_accessor :cells, :rows, :cols

  def initialize(rows=3,cols=3)
    @rows,@cols = rows,cols
    @cells = seed
  end

  def seed
    Array.new(rows) do |y|
      Array.new(cols) do |x|
        Cell.new(self,x,y)
      end
    end
  end

  def cell_count
    cells.flatten.count
  end

  def cell_at_coordinate(x, y)
    cells[y][x] if cells[y]
  end

  def tick!
    state_change = { pending_death: [], pending_life: [] }
    cells.flatten.each do |cell|
      if cell.alive? && (cell.alive_neighbours.count < 2 || cell.alive_neighbours.count > 3)
        state_change[:pending_death] << cell
        # cell.die!
      elsif cell.dead? && (cell.alive_neighbours.count == 3)
        state_change[:pending_life] << cell
        # cell.life!
      end
    end
    state_change[:pending_death].each(&:die!)
    state_change[:pending_life].each(&:life!)
  end

  def populate
    cells.flatten.each do |cell|
      cell.state = ["dead", "alive"].sample
    end
  end

end