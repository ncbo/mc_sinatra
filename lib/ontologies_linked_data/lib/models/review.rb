require_relative "user"
require_relative "ontology"

module LinkedData
  module Models
    class Review < Goo::Base::Resource
      model :review
      validates :creator, :instance_of => { :with => :user }, :presence => true, :cardinality => { :maximum => 1 }
      validates :created, :date_time_xsd => true, :presence => true, :cardinality => { :maximum => 1 }
      validates :body, :presence => true, :cardinality => { :maximum => 1 }
      validates :ontologyReviewed, :instance_of => { :with => :ontology }, :presence => true, :cardinality => { :maximum => 1 }
      validates :usabilityRating, :cardinality => { :maximum => 1 }
      validates :coverageRating, :cardinality => { :maximum => 1 }
      validates :qualityRating, :cardinality => { :maximum => 1 }
      validates :formalityRating, :cardinality => { :maximum => 1 }
      validates :documentationRating, :cardinality => { :maximum => 1 }

      def initialize(attributes = {})
        super(attributes)
      end
    end
  end
end