require_relative '../test_case'

class TestHelloWorld < TestCase
  def test_it_says_hello_world
    get '/hello'
    assert last_response.ok?
    assert_equal '"Hello World"'.downcase, last_response.body.downcase
  end

  def test_it_says_hello_to_a_person
    name = 'Simon'
    get "/hello/#{name}"
    assert last_response.ok?
    assert last_response.body.downcase.include?(name.downcase)
  end

  def test_it_says_hello_with_day_message
    name = 'Simon'
    type_of_day = 'Great'
    message = "Hello #{name}, have a #{type_of_day} day!"
    get "/hello/#{name}/day/#{type_of_day}"
    assert last_response.ok?
    assert last_response.body.downcase.include?(message.downcase)
  end
end