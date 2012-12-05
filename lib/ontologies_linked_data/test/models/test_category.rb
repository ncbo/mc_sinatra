require_relative "../test_case"

class TestCategory < LinkedData::TestCase
  def test_valid_category
    c = LinkedData::Models::Category.new
    assert (not c.valid?)

    # Not valid because not all attributes are present
    c.name = "Test Category"
    c.created = DateTime.parse("2012-10-04T07:00:00.000Z")
    assert (not c.valid?)

    # All attributes now present, should be valid
    c.acronym = "TCG"
    c.description = "Test category description"
    assert c.valid?
  end

  def test_no_duplicate_project_ids
    c1 = LinkedData::Models::Category.new({
        :created => DateTime.parse("2012-10-04T07:00:00.000Z"),
        :name => "Test Category",
        :description => "This is a test category",
        :acronym => "TCG"
      })

    c2 = LinkedData::Models::Category.new({
        :created => DateTime.parse("2012-10-04T07:00:00.000Z"),
        :name => "Test Category",
        :description => "This is a test category",
        :acronym => "TCG"
      })

    # Both should be valid before they are saved
    assert c1.valid?
    assert c2.valid?

    # Only c1 should be valid after save
    c1.save
    assert (not c2.valid?)
    assert c1.valid?

    # Cleanup
    c1.delete
  end


  def test_category_save
    c = LinkedData::Models::Category.new({
        :created => DateTime.parse("2012-10-04T07:00:00.000Z"),
        :name => "Test Category",
        :description => "This is a test category",
        :acronym => "TCG"
      })

    assert_equal false, c.exist?(reload=true)
    c.save
    assert_equal true, c.exist?(reload=true)
    c.delete
    assert_equal false, c.exist?(reload=true)
  end
end