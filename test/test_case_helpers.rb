require_relative '../app'
require 'test/unit'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

# All helper test cases should inherit from this class.
# Use the method 'helper' to access methods in the helper being tested.
#
#   IMPORTANT: Test classes for helpers must be names "TestHelperModule" where "HelperModule"
#   matches the name of the helper module exactly (including case).
# Use 'rake test' from the command line to run tests.
# See http://www.sinatrarb.com/testing.html for testing information
class TestCaseHelpers < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def helper
    class_name = self.class.name.gsub(/^Test/, "")
    extend Kernel.const_get("Sinatra").const_get("Helpers").const_get(class_name)
  end
end