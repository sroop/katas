require 'superfoo'

describe "Superfoo" do

  let(:superfoo) { Superfoo.new }

  context "Data can be added to and retrieved from superfoo" do

    it "using hash syntax" do
      superfoo.data[:buzz] = "BUZZ"
      expect(superfoo.data[:buzz]).to eq("BUZZ")
    end

    it "using basic getter/setters" do
      superfoo.buzz = "BUZZ"
      expect(superfoo.buzz).to eq("BUZZ")
    end

  end

end