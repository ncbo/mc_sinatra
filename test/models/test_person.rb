require_relative '../test_case'

class TestHelloWorld < TestCase
  def test_new_person
    name = "Simon"
    t = Person.new(name)
    assert t.name.downcase.eql? name.downcase
  end

  def test_person_properties
    name = 'Simon'
    adjective = 'Great'
    t = Person.new(name, adjective)
    assert t.name.downcase.eql? name.downcase
    assert t.adjective.downcase.eql? adjective.downcase
  end
end