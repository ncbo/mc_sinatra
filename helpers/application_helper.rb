require 'sinatra/base'

module Sinatra
  module Helpers
    module ApplicationHelper
      SERIALIZER = LinkedData::Serializer.new

      ##
      # Escape text for use in html
      def h(text)
        Rack::Utils.escape_html(text)
      end

      # TODO: This will allow for mass-assignment problems and will allow
      # users to overwrite any attribute, including things like passwords.
      # TODO: This should use a Goo helper method to lookup attribute objects
      # when the exist, for example when you need an IRI or a User object as a value.
      def populate_from_params(obj, params)
        params.each do |attribute, value|
          obj.send("#{attribute}=", value) # if obj.respond_to?("#{attribute}=")
        end
        obj
      end

      def instance_from_params(cls, params)
        n = cls.new
        populate_from_params(n, params)
      end

      ##
      # Serialize objects using a custom serializer that handles content negotiation
      # using the Accept header and "format" query string parameter
      # * +obj+: object to be serialized
      # * +status+: http status code
      def s(obj, status = 200)
        if obj.respond_to?("each")
          obj.each do |sub_obj|
            sub_obj.load unless !sub_obj.respond_to?("loaded?") || sub_obj.loaded?
          end
        else
          obj.load unless !obj.respond_to?("loaded?") || obj.loaded?
        end
        SERIALIZER.build_response(@env, status: status, ld_object: obj)
      end
    end

    helpers ApplicationHelper
  end
end