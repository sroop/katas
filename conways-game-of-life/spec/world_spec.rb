require 'cell'
require 'world'

describe "World" do

  let(:world) { World.new }
  subject { Cell.new(world) }

  context "Utility methods" do

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