module LinkedData
  module Models
    class Ontology < Goo::Base::Resource
      model :ontology
      validates :acronym, :presence => true, :cardinality => { :maximum => 1 }
      validates :name, :presence => true, :cardinality => { :maximum => 1 }
      unique :acronym
    end
  end
end