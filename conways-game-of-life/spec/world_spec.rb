require 'cell'
require 'world'

describe "World" do

  let(:world) { World.new }
  subject { Cell.new(world) }

  context "Utility methods" do

    it "initializes by setting the size of the world" do
      expect(world.rows).to eq(3)
      expect(world.cols).to eq(3)
      new_world = World.new(6,6)
      expect(new_world.rows).to eq(6)
      expect(new_world.cols).to eq(6)
    end

    it "populates cells" do
      expect(world.cells).to eq([subject])
      world.populate
      expect(world.cells.size).to eq(9)
      expect(subject.neighbours.count).to eq(3)
      expect(world.cells[4].neighbours.count).to eq(8)

      # How #populate generates a 3x3 world around a single [0,0] cell:

      # [0,2] [1,2] [2,2]
      # [0,1] [1,1] [2,1]
      # [0,0] [1,0] [2,0]
    end

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

end