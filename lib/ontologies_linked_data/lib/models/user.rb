module LinkedData
  module Models
    class User < Goo::Base::Resource
      model :user
      attribute :username, :unique => true, :cardinality => { :max => 1, :min => 1 }

      def initialize(attributes = {})
        super(attributes)
      end
    end
  end
end