require_relative "../../ontologies_linked_data"
require "test/unit"

class TestUser < Test::Unit::TestCase
  def test_valid_user
    u = LinkedData::Models::User.new
    assert (not u.valid?)

    u.username = "test_user"
    assert u.valid?
  end

  def test_user_save
    u = LinkedData::Models::User.new({
        username: "test_user"
      })

    assert_equal false, u.exist?(reload=true)
    u.save
    assert_equal true, u.exist?(reload=true)
    u.delete
    assert_equal false, u.exist?(reload=true)
  end
end