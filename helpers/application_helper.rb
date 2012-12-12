require 'sinatra/base'

module Sinatra
  module Helpers
    module ApplicationHelper
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
    end

    helpers ApplicationHelper
  end
end