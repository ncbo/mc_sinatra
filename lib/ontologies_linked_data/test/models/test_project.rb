require_relative "../../ontologies_linked_data"
require "test/unit"

class TestProject < Test::Unit::TestCase
  def test_valid_project
    p = LinkedData::Models::Project.new
    assert (not p.valid?)

    # Not valid because not all attributes are present
    p.name = "Great Project"
    p.created = DateTime.parse("2012-10-04T07:00:00.000Z")
    p.homePage = "http://valid.uri.com"
    p.description = "This is a test project"
    assert (not p.valid?)

    # Still not valid because not all attributes are typed properly
    p.creator = "paul"
    p.ontologyUsed = "SNOMED"
    assert (not p.valid?)

    # Fix typing
    p.creator = LinkedData::Models::User.new(username: "paul")
    p.ontologyUsed = [LinkedData::Models::Ontology.new(acronym: "SNOMED", name: "SNOMED CT")]
    assert p.valid?
  end

  def test_project_save
    p = LinkedData::Models::Project.new({
        :name => "Great Project",
        :creator => LinkedData::Models::User.new(username: "paul"),
        :created => DateTime.parse("2012-10-04T07:00:00.000Z"),
        :homePage => "http://valid.uri.com",
        :description => "This is a test description",
        :ontologyUsed => [LinkedData::Models::Ontology.new(acronym: "SNOMED", name: "SNOMED CT")]
      })

    assert_equal false, p.exist?(reload=true)
    p.save
    assert_equal true, p.exist?(reload=true)
    p.delete
    assert_equal false, p.exist?(reload=true)
  end
end