require 'cell'
require 'world'

describe "Cell" do

  let(:world) { World.new }
  let(:subject) { world.cells[1][1] }

  context "Utility methods" do

    it "a dead cell gets spawned at a specified coordinate" do
      cell = subject.spawn_at_coordinate(1,5)
      expect(cell).to be_dead
      expect(cell.is_a?(Cell)).to eq(true)
      expect(cell.x).to eq(1)
      expect(cell.y).to eq(5)
      expect(cell.world).to eq(subject.world)
    end

    it "knows if it is alive" do
      subject.life!
      expect(subject.state).to eq("alive")
    end

    it "knows if it is dead" do
      expect(subject.state).to eq("dead")
    end

    it "a dead cell can be brought to life" do
      subject.life!
      expect(subject).to be_alive
    end

    it "a live cell can die" do
      subject.life!
      subject.die!
      expect(subject).to be_dead
      expect(subject.world.cells.flatten).to include(subject)
    end

    it "detects dead and alive neighbouring cells" do
      expected_cell_neighbours =  [ [0, 0],[1, 0],[2, 0],[0, 1],[2, 1],[0, 2],[1, 2],[2, 2] ]
      actual_cell_neighbours =  subject.neighbours.map { |cell| [cell.x, cell.y] }
      expect(actual_cell_neighbours.count).to eq(8)
      expect(actual_cell_neighbours).to eq(expected_cell_neighbours)
    end

    it "detects a neighbouring live cell to the north" do
      north_cell = world.cells[2][1]
      north_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the north-east" do
      north_east_cell = world.cells[2][2]
      north_east_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the east" do
      east_cell = world.cells[1][2]
      east_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south-east" do
      south_east_cell = world.cells[0][2]
      south_east_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south" do
      south_cell = world.cells[0][1]
      south_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the south-west" do
      south_west_cell = world.cells[0][0]
      south_west_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the west" do
      west_cell = world.cells[1][0]
      west_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "detects a neighbouring live cell to the north-west" do
      north_west_cell = world.cells[2][0]
      north_west_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
    end

    it "cannot detect a cell that isn't a neighbour" do
      north_west_cell = world.cells[0][2]
      south_east_cell = world.cells[2][0]
      north_west_cell.life!
      expect(south_east_cell.alive_neighbours.count).to eq(0)
    end

    it "cannot detect a neighbouring dead cell" do
      north_cell = world.cells[2][1]
      north_cell.life!
      expect(subject.alive_neighbours.count).to eq(1)
      north_cell.die!
      expect(subject.alive_neighbours.count).to eq(0)
    end

  end

end
