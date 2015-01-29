require 'cell'
require 'world'

describe "Game of Life" do

  let(:world) { World.new }
  subject { Cell.new(world) }

  context "Rule #1" do

    it "Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
      cell = subject.spawn_at_coordinate(1,0)
      [subject,cell].each(&:life!)
      subject.assign_neighbours
      expect(subject.alive_neighbours.count).to eq(1)
      cell.assign_neighbours
      expect(cell.alive_neighbours.count).to eq(1)
      world.tick!
      expect(subject).to be_dead
      expect(cell).to be_dead
      expect(cell.alive_neighbours.count).to eq(0)
      expect(subject.alive_neighbours.count).to eq(0)
    end

  end

  context "Rule #2" do

    it "Any live cell with two live neighbours lives on to the next generation" do
      cell1 = subject.spawn_at_coordinate(1,0)
      cell2 = subject.spawn_at_coordinate(-1,0)
      [subject,cell1,cell2].each(&:life!)
      [subject,cell1,cell2].each(&:assign_neighbours)
      expect(subject.alive_neighbours.count).to eq(2)
      expect(cell1.alive_neighbours.count).to eq(1)
      expect(cell2.alive_neighbours.count).to eq(1)

      world.tick!

      expect(subject).to be_alive
      expect(cell1).to be_dead
      expect(cell2).to be_dead
    end

    it "Any live cell with three live neighbours lives on to the next generation" do
      new_cell1 = subject.spawn_at_coordinate(1,1)
      new_cell2 = subject.spawn_at_coordinate(1,-1)
      new_cell3 = subject.spawn_at_coordinate(-1,1)
      [new_cell1,new_cell2,new_cell3].each(&:life!)
      [subject,new_cell1,new_cell2,new_cell3].each(&:assign_neighbours)
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
      [cell1,cell2,cell3,cell4].each(&:life!)
      [subject,cell1,cell2,cell3,cell4].each(&:assign_neighbours)
      expect(subject.alive_neighbours.count).to eq(4)
      world.tick!
      expect(subject).to be_dead
    end

  end

  context "Rule #4" do

    it "Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction" do
      cell1 = subject.spawn_at_coordinate(1,-1)
      cell2 = subject.spawn_at_coordinate(0,-1)
      cell3 = subject.spawn_at_coordinate(-1,1)
      [cell1,cell2,cell3].each(&:life!)
      [subject,cell1,cell2,cell3].each(&:assign_neighbours)
      expect(subject).to be_dead
      world.tick!
      expect(subject).to be_alive
    end

  end

end

