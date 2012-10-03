require_relative '../test_case_helpers'

class TestMessageHelper < TestCaseHelpers
  def test_it_says_hello_to_a_person
    name = 'Simon'
    p = Person.new(name)
    assert helper.hello_message(p).eql? "Hello Simon"
  end

  def test_it_says_hello_with_day_message
    name = 'Simon'
    type_of_day = 'Great'
    p = Person.new(name, type_of_day)
    message = "Hello #{name}, have a #{type_of_day} day!"
    assert helper.hello_message_day(p).downcase.eql? message.downcase
  end
end