class World

  attr_accessor :cells, :alive_cells, :dead_cells

  def initialize
    @cells = []
    @alive_cells = []
    @dead_cells = []
  end

  def tick!
    cells.each do | cell |
      if cell.neighbours.count < 2 || cell.neighbours.count > 3
        cell.die! if cell.alive?
      elsif cell.neighbours.count == 3
        cell.life! if cell.dead?
      end
    end
  end

end