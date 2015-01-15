class World

  attr_accessor :cells, :alive_cells, :dead_cells

  def initialize
    @cells = []
    @alive_cells = []
    @dead_cells = []
  end

  def tick!
    cells.each do | cell |
      if cell.alive? && (cell.neighbours.count < 2 || cell.neighbours.count > 3)
        cell.die!
      elsif cell.dead? && cell.neighbours.count == 3
        cell.life!
      end
    end
  end

end