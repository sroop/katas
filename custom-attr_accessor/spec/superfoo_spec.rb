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

  context "data_accessor :banana, :apple" do

    let(:subfoo) { Subfoo.new }

    it "Sets the key :banana to the value 'yellow'" do
      subfoo.banana = "yellow"
      expect(subfoo.banana).to eq("yellow")
    end

    it "Sets the key :apple to the value 'green'" do
      subfoo.apple = "green"
      expect(subfoo.apple).to eq("green")
    end

    it "Doesn't set the key :orange to the value 'orange'" do
      expect{subfoo.orange = "orange"}.to raise_error(NoMethodError)
    end

  end

end