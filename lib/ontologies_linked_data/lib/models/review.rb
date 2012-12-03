require_relative "user"
require_relative "ontology"

module LinkedData
  module Models
    class Review < Goo::Base::Resource
      model :review
      attribute :creator, :instance_of => { :with => :user }, :cardinality => { :max => 1, :min => 1 }
      attribute :created, :date_time_xsd => true, :cardinality => { :max => 1, :min => 1 }
      attribute :body, :cardinality => { :max => 1, :min => 1}
      attribute :ontologyReviewed, :instance_of => { :with => :ontology }, :cardinality => { :max => 1, :min => 1 }
      attribute :usabilityRating, :cardinality => { :max => 1 }
      attribute :coverageRating, :cardinality => { :max => 1 }
      attribute :qualityRating, :cardinality => { :max => 1 }
      attribute :formalityRating, :cardinality => { :max => 1 }
      attribute :documentationRating, :cardinality => { :max => 1 }

      def initialize(attributes = {})
        super(attributes)
      end
    end
  end
end