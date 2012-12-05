require_relative "../test_case"

class TestOntology < LinkedData::TestCase
  def test_valid_ontology
    o = LinkedData::Models::Ontology.new
    assert (not o.valid?)

    o.acronym = "SNOMED"
    o.name = "SNOMED CT"
    assert o.valid?
  end

  def test_ontology_save
    o = LinkedData::Models::Ontology.new({
        acronym: "NEW_ONT",
        name: "Test Ontology"
      })

    assert_equal false, o.exist?(reload=true)
    o.save
    assert_equal true, o.exist?(reload=true)
    o.delete
    assert_equal false, o.exist?(reload=true)
  end
end