require_relative '../app'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

# All tests should inherit from this class.
# Use 'rake test' from the command line to run tests.
# See http://www.sinatrarb.com/testing.html for testing information
class TestCase < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

end