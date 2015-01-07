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

end