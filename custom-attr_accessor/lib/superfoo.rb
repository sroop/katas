class Superfoo

  attr_accessor :data

  def initialize
    @data = {}
  end

  def buzz
    @data[:buzz]
  end

  def buzz=(value)
    @data[:buzz] = value
  end

  def self.data_accessor(*method_names)
    method_names.each do |method_name|
      define_method(method_name) do
        @data[method_name]
      end
      define_method("#{method_name}=") do |value|
        @data[method_name] = value
      end
    end
  end

end

class Subfoo < Superfoo
  data_accessor :banana, :apple
end