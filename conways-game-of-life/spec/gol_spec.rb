require 'cell'
require 'world'

describe "Conways Game of Life" do

  let(:world) { World.new }

  context "Cell methods" do

    subject { Cell.new(world) }

    it "#spawns_at_coordinate" do
      cell = subject.spawn_at_coordinate(1,5)
      expect(cell.is_a?(Cell)).to eq(true)
      expect(cell.x).to eq(1)
      expect(cell.y).to eq(5)
      expect(cell.world).to eq(subject.world)
    end

    it "detects a neighbouring cell to the north" do
      cell = subject.spawn_at_coordinate(0,1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring cell to the north-east" do
      cell = subject.spawn_at_coordinate(1,1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring cell to the east" do
      cell = subject.spawn_at_coordinate(1,0)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring cell to the south-east" do
      cell = subject.spawn_at_coordinate(1,-1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring cell to the south" do
      cell = subject.spawn_at_coordinate(0,-1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring cell to the south-west" do
      cell = subject.spawn_at_coordinate(-1,-1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring cell to the west" do
      cell = subject.spawn_at_coordinate(-1,0)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring cell to the north-west" do
      cell = subject.spawn_at_coordinate(1,-1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "cannot detect a cell that isn't a neighbour" do
      cell = subject.spawn_at_coordinate(2,0)
      expect(cell.neighbours.count).to eq(0)
    end

  end

  context "Rule #1" do

    subject { Cell.new(world) }

    it "Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
      cell = Cell.new(world)
      expect(cell.neighbours.count).to eq(0)
    end

  end

end

