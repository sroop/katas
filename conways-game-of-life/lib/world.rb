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
    cells.flatten.each do |cell|
      case cell.state
      when "alive"
        if cell.alive_neighbours.count < 2 || cell.alive_neighbours.count > 3
          cell.die!
        end
      when "dead"
        if cell.alive_neighbours.count == 3
          cell.life!
        end
      end
    end
  end

  def populate
    cells.flatten.each do |cell|
      cell.state = ["dead", "alive"].sample
    end
  end

end