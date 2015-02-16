require 'cell'
require 'world'

describe "Game of Life" do

  let(:world) { World.new }
  let(:subject) { world.cells[1][1] }
  let(:north_west_neighbour) { world.cells[0][2] }
  let(:west_neighbour) { world.cells[0][1] }
  let(:north_neighbour) { world.cells[1][2]}
  let(:east_neighbour) { world.cells[2][1] }

  context "Rule #1" do

    it "Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
      [subject, north_west_neighbour].each(&:life!)
      expect(subject.alive_neighbours.count).to eq(1)
      expect(north_west_neighbour.alive_neighbours.count).to eq(1)
      world.tick!
      expect(subject).to be_dead
      expect(north_west_neighbour).to be_dead
      expect(north_west_neighbour.alive_neighbours.count).to eq(0)
      expect(subject.alive_neighbours.count).to eq(0)
    end

  end

  context "Rule #2" do

    it "Any live cell with two live neighbours lives on to the next generation" do
      [subject,north_west_neighbour,west_neighbour].each(&:life!)
      expect(subject.alive_neighbours.count).to eq(2)
      expect(north_west_neighbour.alive_neighbours.count).to eq(2)
      expect(west_neighbour.alive_neighbours.count).to eq(2)
      world.tick!
      expect(subject).to be_alive
    end

    it "Any live cell with three live neighbours lives on to the next generation" do
      [subject,north_west_neighbour,west_neighbour,north_neighbour].each(&:life!)
      world.tick!
      expect(subject).to be_alive
    end

  end

  context "Rule #3" do

    it "Any live cell with more than three live neighbours dies, as if by overcrowding" do
      [subject, north_west_neighbour, west_neighbour, east_neighbour, north_neighbour].each(&:life!)
      expect(subject).to be_alive
      expect(subject.alive_neighbours.count).to eq(4)
      world.tick!
      expect(subject).to be_dead
    end

  end

  context "Rule #4" do

    it "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction" do
      [north_neighbour, east_neighbour, north_west_neighbour].each(&:life!)
      expect(subject.alive_neighbours.count).to eq(3)
      expect(subject).to be_dead
      world.tick!
      expect(subject).to be_alive
    end

  end

end

