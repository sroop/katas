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
  end

  def tick!
    cells.each do |cell|
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
    cells.each do |cell|
      cell.state = ["dead", "alive"].sample
      self.send("#{cell.state}_cells") << cell
    end
  end

  def meet_the_neighbours
    cells.each do |cell|
      cell.assign_neighbours
    end
    alive_cells.each do |cell|
      cell.alive_neighbours
    end
  end

end