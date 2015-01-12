require 'cell'
require 'world'

describe "Conways Game of Life" do

  let(:world) { World.new }
  subject { Cell.new(world) }

  context "Cell methods" do

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

    it "dies" do
      subject.die!
      expect(subject.world.cells).to_not include(subject)
    end

  end

  context "Rule #1" do

    it "Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
      cell = subject.spawn_at_coordinate(1,0)
      expect(subject.neighbours.count).to eq(1)
      expect(cell.neighbours.count).to eq(1)
      world.tick!
      expect(subject).to be_dead
      expect(cell).to be_dead
      expect(cell.neighbours.count).to eq(0)
      expect(subject.neighbours.count).to eq(0)
    end

  end

  context "Rule #2" do

    it "Any live cell with two or three live neighbours lives on to the next generation" do
      cell1 = subject.spawn_at_coordinate(1,0)
      cell2 = subject.spawn_at_coordinate(-1,0)
      expect(subject.neighbours.count).to eq(2)
      expect(cell1.neighbours.count).to eq(1)
      expect(cell2.neighbours.count).to eq(1)

      world.tick!

      expect(subject).to_not be_dead
      expect(cell1).to be_dead
      expect(cell2).to be_dead

      new_cell1 = subject.spawn_at_coordinate(1,1)
      new_cell2 = subject.spawn_at_coordinate(1,-1)
      new_cell3 = subject.spawn_at_coordinate(-1,1)

      world.tick!

      expect(subject).to_not be_dead
    end

  end

  context "Rule #3" do

    it "Any live cell with more than three live neighbours dies, as if by overcrowding" do
      cell1 = subject.spawn_at_coordinate(1,0)
      cell2 = subject.spawn_at_coordinate(-1,0)
      cell3 = subject.spawn_at_coordinate(1,1)
      cell4 = subject.spawn_at_coordinate(1, -1)
      expect(subject.neighbours.count).to eq(4)
      world.tick!
      expect(subject).to be_dead
    end

  end

end

