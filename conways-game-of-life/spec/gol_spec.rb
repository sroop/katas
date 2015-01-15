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

    it "detects a neighbouring live cell to the north" do
      cell = subject.spawn_at_coordinate(0,1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the north-east" do
      cell = subject.spawn_at_coordinate(1,1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the east" do
      cell = subject.spawn_at_coordinate(1,0)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south-east" do
      cell = subject.spawn_at_coordinate(1,-1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south" do
      cell = subject.spawn_at_coordinate(0,-1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south-west" do
      cell = subject.spawn_at_coordinate(-1,-1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the west" do
      cell = subject.spawn_at_coordinate(-1,0)
      expect(subject.neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the north-west" do
      cell = subject.spawn_at_coordinate(1,-1)
      expect(subject.neighbours.count).to eq(1)
    end

    it "cannot detect a cell that isn't a neighbour" do
      cell = subject.spawn_at_coordinate(2,0)
      expect(cell.neighbours.count).to eq(0)
    end

    it "cannot detect a neighbouring dead cell" do
      cell = subject.spawn_at_coordinate(1,0)
      expect(subject.neighbours.count).to eq(1)
      cell.die!
      expect(subject.neighbours.count).to eq(0)
    end

    it "dies" do
      subject.die!
      expect(subject.world.dead_cells).to include(subject)
      expect(subject.world.alive_cells).to_not include(subject)
      expect(subject.world.cells).to include(subject)
    end

    it "can be brought back to life after death" do
      subject.die!
      subject.life!
      expect(subject.world.alive_cells).to include(subject)
      expect(subject.world.dead_cells).to_not include(subject)
      expect(subject.world.cells).to include(subject)
    end

    it "knows if it is alive" do
      expect(subject).to be_alive
    end

    it "knows if it is dead" do
      subject.die!
      expect(subject).to be_dead
    end

  end

  context "World methods" do

    it "detects all alive cells" do
      subject.spawn_at_coordinate(1,0)
      subject.spawn_at_coordinate(1,1)
      subject.spawn_at_coordinate(3,4)
      expect(world.alive_cells.count).to eq(4)
    end

    it "detects all dead cells" do
      subject.spawn_at_coordinate(1,0)
      subject.spawn_at_coordinate(1,1)
      subject.spawn_at_coordinate(3,4)
      subject.die!
      expect(world.dead_cells.count).to eq(1)
      expect(world.cells.count).to eq(4)
      expect(world.alive_cells.count).to eq(3)
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

    it "Any live cell with two live neighbours lives on to the next generation" do
      cell1 = subject.spawn_at_coordinate(1,0)
      cell2 = subject.spawn_at_coordinate(-1,0)
      expect(subject.neighbours.count).to eq(2)
      expect(cell1.neighbours.count).to eq(1)
      expect(cell2.neighbours.count).to eq(1)

      world.tick!

      expect(subject).to be_alive
      expect(cell1).to be_dead
      expect(cell2).to be_dead
    end

    it "Any live cell with three live neighbours lives on to the next generation" do
      new_cell1 = subject.spawn_at_coordinate(1,1)
      new_cell2 = subject.spawn_at_coordinate(1,-1)
      new_cell3 = subject.spawn_at_coordinate(-1,1)

      world.tick!

      expect(subject).to be_alive
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

  context "Rule #4" do

    it "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction" do
      cell1 = subject.spawn_at_coordinate(1,-1)
      cell2 = subject.spawn_at_coordinate(0,-1)
      cell3 = subject.spawn_at_coordinate(-1,1)
      subject.die!
      expect(subject).to be_dead
      world.tick!
      expect(subject).to be_alive
    end

  end

end

