require 'superfoo'

describe "Superfoo" do

  context "Superfoo" do

    it "is defined as a class" do
      expect(Superfoo.new).to be_instance_of(Superfoo)
    end

    it "defines the method 'data_accessor'" do
      expect(Superfoo).to respond_to(:data_accessor)
    end

  end

  context "Superfoo instance" do

    let(:superfoo) { Superfoo.new }

    it "defines the method 'data'" do
      expect(superfoo).to respond_to(:data)
    end

    it "defines the method 'data='" do
      expect(superfoo).to respond_to(:data=)
    end

    it "initializes data with an empty hash" do
      expect(superfoo.data).to eq({})
    end

    it "does not define the method 'data_accessor'" do
      expect(superfoo).to_not respond_to(:data_accessor)
    end

  end

  context "Subfoo" do

    it "defines the method 'data_accessor'" do
      expect(Subfoo).to respond_to(:data_accessor)
    end

  end

  context "Subfoo instance" do

    let(:subfoo) { Subfoo.new }

    it "defines the method 'data'" do
      expect(subfoo).to respond_to(:data)
    end

    it "defines the method 'data='" do
      expect(subfoo).to respond_to(:data=)
    end

    it "initializes data with an empty hash" do
      expect(subfoo.data).to eq({})
    end

    it "does not define the method 'data_accessor'" do
      expect(subfoo).to_not respond_to(:data_accessor)
    end

    it "defines the method 'banana'" do
      expect(subfoo).to respond_to(:banana)
    end

    it "defines the method 'banana='" do
      expect(subfoo).to respond_to(:banana=)
    end

    it "defines the method 'apple'" do
      expect(subfoo).to respond_to(:apple)
    end

    it "defines the method 'apple='" do
      expect(subfoo).to respond_to(:apple=)
    end

    it "does not define the method 'orange'" do
      expect(subfoo).to_not respond_to(:orange)
      expect{subfoo.orange = "orange"}.to raise_error(NoMethodError)
    end

    it "does not define the method 'orange='" do
      expect(subfoo).to_not respond_to(:orange=)
    end

    it "starts with nil values" do
      expect(subfoo.banana).to eq(nil)
      expect(subfoo.apple).to eq(nil)
    end

    it "sets and gets values" do
      subfoo.banana = "yellow"
      subfoo.apple = "green"
      expect(subfoo.banana).to eq("yellow")
      expect(subfoo.apple).to eq("green")
    end

    it "only has the @data instance variable" do
      expect(subfoo.instance_variables).to eq([:@data])
    end

  end

end