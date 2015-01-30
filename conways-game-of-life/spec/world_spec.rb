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

    it "seeds the world with dead cells" do
      expect(world.cells).to eq([subject])
      world.seed
      expect(world.cells.size).to eq(9)
      world.cells.each do |cell|
        expect(cell.dead?).to eq(true)
      end

      # How #seed generates a 3x3 world around a single [0,0] cell:

      # [0,2] [1,2] [2,2]
      # [0,1] [1,1] [2,1]
      # [0,0] [1,0] [2,0]

      # @cells = [ [0,0], [1,0], [2,0], [0,1], [1,1], [2,1], [0,2], [1,2], [2,2] ]
    end

    it "detects all dead cells" do
      subject.spawn_at_coordinate(1,0)
      subject.spawn_at_coordinate(1,1)
      subject.spawn_at_coordinate(3,4)
      expect(world.dead_cells.count).to eq(4)
    end

    it "detects all alive cells" do
      subject.spawn_at_coordinate(1,0)
      subject.spawn_at_coordinate(1,1)
      subject.spawn_at_coordinate(3,4)
      subject.life!
      expect(world.alive_cells.count).to eq(1)
      expect(world.cells.count).to eq(4)
      world.dead_cells.each(&:life!)
      expect(world.alive_cells.count).to eq(4)
    end

    it "populates a freshly seeded world with live cells" do
      expect(world.cells).to eq([subject])
      world.seed
      expect(world.alive_cells).to be_empty
      expect(subject).to be_dead
      expect(world.cells.count).to eq(9)
      world.populate
      expect(world.alive_cells.count).to be > 0
      world.alive_cells.each do |cell|
        expect(cell).to be_alive
      end
    end

  end

end