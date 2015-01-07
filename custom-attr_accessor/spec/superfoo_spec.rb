require 'superfoo'

describe "Superfoo" do

  let(:superfoo) { Superfoo.new }

  it "Data can be added to and then retrieved from superfoo" do
    superfoo.data[:buzz] = "BUZZ"
    expect(superfoo.data[:buzz]).to eq("BUZZ")
  end

end