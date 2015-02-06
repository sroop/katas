require 'cell'
require 'world'

describe "World" do

  let(:world) { World.new }

  context "Utility methods" do

    it "initializes by setting the size of the world" do
      expect(world.rows).to eq(3)
      expect(world.cols).to eq(3)
      new_world = World.new(6,6)
      expect(new_world.rows).to eq(6)
      expect(new_world.cols).to eq(6)
    end

    it "seeds the world with dead cells on initialization" do
      expect(world.cell_count).to eq(9)

      expected_cell_grid =  [
                              [[0, 0],[1, 0],[2, 0]], #    South
                              [[0, 1],[1, 1],[2, 1]], #  West East
                              [[0, 2],[1, 2],[2, 2]] #     North
                            ]

      actual_cell_grid =  world.cells.map do |row|
                            row.map do |cell|
                              [cell.x, cell.y]
                            end
                          end

      expect(actual_cell_grid).to eq(expected_cell_grid)

      world.cells.flatten.each do |cell|
        expect(cell.dead?).to eq(true)
      end
    end

    it 'can retrieve any cell object given a coordinate' do
      subject = world.cells[1][1]
      expect(world.cell_at_coordinate(1,1)).to eq(subject)
      north_east_cell = world.cells[2][2]
      expect(world.cell_at_coordinate(2,2)).to eq(north_east_cell)
    end

    it "detects all dead and alive cells throughout state changes" do
      expect(world.cell_count).to eq(9)
      subject = world.cells.first.first
      expect(subject).to be_dead
      subject.life!
      expect(subject).to be_alive
      expect(world.cell_count).to eq(9)
    end

    it "populates a freshly seeded world with live cells" do
      alive_cells = []
      dead_cells = []
      expect(world.cell_count).to eq(9)
      world.populate
      world.cells.flatten.each do |cell|
        alive_cells << cell if cell.alive?
        dead_cells << cell if cell.dead?
      end
      expect(alive_cells).to_not be_empty
      expect(dead_cells).to_not be_empty
    end

  end

end