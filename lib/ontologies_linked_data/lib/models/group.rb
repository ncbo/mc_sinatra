module LinkedData
  module Models
    class Group < Goo::Base::Resource
      model :group
      attribute :created, :date_time_xsd => true, :cardinality => { :max => 1, :min => 1 }
      attribute :name, :cardinality => { :max => 1, :min => 1 }
      attribute :acronym, :unique => true, :cardinality => { :max => 1, :min => 1 }
      attribute :description, :cardinality => { :max => 1, :min => 1 }

      def initialize(attributes = {})
        super(attributes)
      end
    end
  end
end