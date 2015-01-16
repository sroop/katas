require 'cell'
require 'world'

describe "Cell" do

  let(:world) { World.new }
  subject { Cell.new(world) }

  context "Utility methods" do

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

end
