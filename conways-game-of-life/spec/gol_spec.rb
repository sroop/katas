describe "Conways Game of Life" do

  context "Rule #1"

  it "Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
    cell = Cell.new
    expect(cell.neighbours_count).to eq(0)
  end

end

