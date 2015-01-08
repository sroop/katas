require 'cell'

describe "Conways Game of Life" do

  context "Cell methods" do

    subject { Cell.new }

    it "#spawns_at_coordinate" do
      cell = subject.spawn_at_coordinate(1,5)
      expect(cell.is_a?(Cell)).to eq(true)
      expect(cell.x).to eq(1)
      expect(cell.y).to eq(5)
    end

  end

  context "Rule #1" do

    it "Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
      cell = Cell.new
      expect(cell.neighbours.count).to eq(0)
    end

  end

end

