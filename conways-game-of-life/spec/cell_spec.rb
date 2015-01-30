require 'cell'
require 'world'

describe "Cell" do

  let(:world) { World.new }
  subject { Cell.new(world) }

  context "Utility methods" do

    it "a dead cell gets spawned at a specified coordinate" do
      cell = subject.spawn_at_coordinate(1,5)
      expect(cell).to be_dead
      expect(cell.is_a?(Cell)).to eq(true)
      expect(cell.x).to eq(1)
      expect(cell.y).to eq(5)
      expect(cell.world).to eq(subject.world)
    end

    it "a dead cell can be brought to life" do
      subject.life!
      expect(subject.world.alive_cells).to include(subject)
      expect(subject.world.dead_cells).to_not include(subject)
      expect(subject.world.cells).to include(subject)
    end

    it "a live cell can die" do
      subject.life!
      subject.die!
      expect(subject.world.dead_cells).to include(subject)
      expect(subject.world.alive_cells).to_not include(subject)
      expect(subject.world.cells).to include(subject)
    end

    it "knows if it is alive" do
      subject.life!
      expect(subject).to be_alive
      expect(subject.state).to eq("alive")
    end

    it "knows if it is dead" do
      expect(subject).to be_dead
      expect(subject.state).to eq("dead")
    end

    it "detects dead and alive neighbouring cells" do
      [-1,0,1].each do |x|
        [-1,0,1].each do |y|
          subject.spawn_at_coordinate(x,y)
        end
      end
      subject.assign_neighbours
      expect(subject.neighbours.count).to eq(8)
    end

    it "detects a neighbouring live cell to the north" do
      cell = subject.spawn_at_coordinate(0,1)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the north-east" do
      cell = subject.spawn_at_coordinate(1,1)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the east" do
      cell = subject.spawn_at_coordinate(1,0)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south-east" do
      cell = subject.spawn_at_coordinate(1,-1)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south" do
      cell = subject.spawn_at_coordinate(0,-1)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south-west" do
      cell = subject.spawn_at_coordinate(-1,-1)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the west" do
      cell = subject.spawn_at_coordinate(-1,0)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the north-west" do
      cell = subject.spawn_at_coordinate(1,-1)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "cannot detect a cell that isn't a neighbour" do
      cell = subject.spawn_at_coordinate(2,0)
      cell.life!
      cell.assign_neighbours
      expect(cell.alive_neighbours.count).to eq(0)
    end

    it "cannot detect a neighbouring dead cell" do
      cell = subject.spawn_at_coordinate(1,0)
      cell.life!
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
      cell.die!
      expect(subject.alive_neighbours.count).to eq(0)
    end

  end

end
