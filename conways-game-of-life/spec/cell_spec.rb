require 'cell'
require 'world'

describe "Cell" do

  let(:world) { World.new }
  let(:subject) { world.cells[1][1] }
  let(:north_cell) { world.cells[2][1] }
  let(:east_cell) { world.cells[1][2] }
  let(:south_cell) { world.cells[0][1] }
  let(:west_cell) { world.cells[1][0] }

  context "Utility methods" do

    it "a dead cell gets spawned at a specified coordinate" do
      cell = subject.spawn_at_coordinate(1,5)
      expect(cell).to be_dead
      expect(cell.is_a?(Cell)).to eq(true)
      expect(cell.x).to eq(1)
      expect(cell.y).to eq(5)
      expect(cell.world).to eq(subject.world)
    end

    context "State" do

      it "knows if it is alive" do
        subject.life!
        expect(subject.state).to eq("alive")
      end

      it "knows if it is dead" do
        expect(subject.state).to eq("dead")
      end

      it "a dead cell can be brought to life" do
        expect(subject).to be_dead
        subject.life!
        expect(subject).to be_alive
      end

      it "a live cell can die" do
        subject.life!
        subject.die!
        expect(subject).to be_dead
        expect(subject.world.cells.flatten).to include(subject)
      end

    end

    context "Neighbours" do

      it "knows its neighbouring cells (dead and alive)" do
        expected_cell_neighbours =  [ [0, 0],[1, 0],[2, 0],[0, 1],[2, 1],[0, 2],[1, 2],[2, 2] ]
        actual_cell_neighbours =  subject.neighbours.map { |cell| [cell.x, cell.y] }
        expect(actual_cell_neighbours.count).to eq(8)
        expect(actual_cell_neighbours).to eq(expected_cell_neighbours)
      end

      it "detects a live neighbour to the north" do
        north_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
      end

      it "detects a live neighbour to the north-east" do
        north_east_cell = world.cells[2][2]
        north_east_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
      end

      it "detects a live neighbour to the east" do
        east_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
      end

      it "detects a live neighbour to the south-east" do
        south_east_cell = world.cells[0][2]
        south_east_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
      end

      it "detects a live neighbour to the south" do
        south_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
      end

      it "detects a live neighbour to the south-west" do
        south_west_cell = world.cells[0][0]
        south_west_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
      end

      it "detects a live neighbour to the west" do
        west_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
      end

      it "detects a live neighbour to the north-west" do
        north_west_cell = world.cells[2][0]
        north_west_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
      end

      it "cannot detect a cell that isn't a neighbour" do
        big_world = World.new(6, 6)
        north_west_cell = big_world.cells[5][0]
        no_neighbours = big_world.cells[2][3]
        north_west_cell.life!
        expect(no_neighbours.alive_neighbours.count).to eq(0)
      end

      it "detects its neighbour when live, but not when state changes to dead" do
        north_cell.life!
        expect(subject.alive_neighbours.count).to eq(1)
        north_cell.die!
        expect(subject.alive_neighbours.count).to eq(0)
      end

    end

    context "An edgeless world" do

      it "cells know if they are on the northern edge" do
        expect(north_cell.north_edge?).to eq(true)
      end

      it "cells know if they are on the southern edge" do
        expect(south_cell.south_edge?).to eq(true)
      end

      it "cells know if they are on the eastern edge" do
        expect(east_cell.east_edge?).to eq(true)
      end

      it "cells know if they are on the western edge" do
        expect(west_cell.west_edge?).to eq(true)
      end

      it "cells know if they aren't on the edge" do
        expect(subject.north_edge?).to eq(false)
        expect(subject.south_edge?).to eq(false)
        expect(subject.east_edge?).to eq(false)
        expect(subject.west_edge?).to eq(false)
      end

      context "Cells that appear on the edge of the board have 8 neighbours in an edgeless world" do

        before { world.cells.flatten.each(&:life!) }

        it "on the eastern edge" do
          expect(east_cell.alive_neighbours.count).to eq(8)
          expected_neighbours = [ [1,0], [2,0], [0,0], [1,1], [0,1], [1,2], [2,2], [0,2] ]
          actual_neighbours =   east_cell.alive_neighbours.map do |cell|
                                  [cell.x, cell.y]
                                end
          expect(actual_neighbours).to match_array(expected_neighbours)
        end

        it "on the western edge" do
          expect(west_cell.alive_neighbours.count).to eq(8)
          expected_neighbours = [ [2,0], [0,0], [1,0], [2,1], [1,1], [2,2], [0,2], [1,2] ]
          actual_neighbours =   west_cell.alive_neighbours.map do |cell|
                                  [cell.x, cell.y]
                                end
          expect(actual_neighbours).to match_array(expected_neighbours)
        end

        it "on the northern edge" do
          expect(north_cell.alive_neighbours.count).to eq(8)
          expected_neighbours = [ [0,1], [1,1], [2,1], [0,2], [2,2], [0,0], [1,0], [2,0] ]
          actual_neighbours =   north_cell.alive_neighbours.map do |cell|
                                  [cell.x, cell.y]
                                end
          expect(actual_neighbours).to match_array(expected_neighbours)
        end

        it "on the southern edge" do
          expect(south_cell.alive_neighbours.count).to eq(8)
          expected_neighbours = [ [0,2], [1,2], [2,2], [0,0], [2,0], [0,1], [1,1], [2,1] ]
          actual_neighbours =   south_cell.alive_neighbours.map do |cell|
                                  [cell.x, cell.y]
                                end
          expect(actual_neighbours).to match_array(expected_neighbours)
        end

        it "in the middle" do
          expect(subject.alive_neighbours.count).to eq(8)
        end

        it "every cell has 8 neighbours in a 3x3 world" do
          world.cells.flatten.each do |cell|
            expect(cell.alive_neighbours.count).to eq(8)
          end
        end

        it "every cell has 8 neighbours in a bigger 6x6 world" do
          big_world = World.new(6,6)
          big_world.cells.flatten.each(&:life!)
          south_east_corner = big_world.cells[0][5]
          expect(south_east_corner.alive_neighbours.count).to eq(8)
          expected_neighbours = [ [4,5], [5,5], [0,5], [4,0], [0,0], [4,1], [5,1], [0,1] ]
          actual_neighbours =   south_east_corner.alive_neighbours.map do |cell|
                                  [cell.x, cell.y]
                                end
          expect(actual_neighbours).to match_array(expected_neighbours)

          big_world.cells.flatten.each do |cell|
            expect(cell.alive_neighbours.count).to eq(8)
          end
        end


      end

    end

  end

end
