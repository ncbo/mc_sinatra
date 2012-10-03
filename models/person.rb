class Person
  attr_accessor :name, :adjective

  def initialize(name, adjective = "")
    @name = name.capitalize; @adjective = adjective.downcase
  end
end