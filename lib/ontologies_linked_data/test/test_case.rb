require_relative "../config/default.rb"
require_relative "../ontologies_linked_data"
require "test/unit"

LinkedData.config(port: GOO_PORT, host: GOO_HOST)

module LinkedData
  class TestCase < Test::Unit::TestCase
  end
end