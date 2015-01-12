class World

  attr_accessor :cells

  def initialize
    @cells = []
  end

  def tick!
    cells.each do | cell |
      if cell.neighbours.count < 2
        cell.die!
      end
    end
  end

end