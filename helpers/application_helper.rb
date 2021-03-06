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

      ##
      # Populate +obj+ using values from +params+
      # Will also try to find related objects using a Goo lookup.
      # TODO: Currerntly, this allows for mass-assignment of everything, which will permit
      # users to overwrite any attribute, including things like passwords.
      # TODO: We should only mass-assign attributes that are declared (if obj.respond_to?...)
      def populate_from_params(obj, params)
        obj.load if obj.kind_of?(Goo::Base::Resource) && obj.lazy_loaded?
        params.each do |attribute, value|
          attr_cls = obj.class.range_class(attribute)
          no_unique_attr = !attr_cls.nil? && (attr_cls.goop_settings[:unique][:fields].nil? || attr_cls.goop_settings[:unique][:fields].length != 1)
          if attr_cls && no_unique_attr
            # binding.pry if attr_cls == LinkedData::Models::Contact
            found_objs = attr_cls.where(value)
            if found_objs.nil? || found_objs.empty?
              new_obj = attr_cls.new(value)
              value = new_obj
            else
              value = found_objs
            end
          elsif attr_cls
            value = attr_cls.find(value)
          end
          obj.send("#{attribute}=", value) if obj.respond_to?("#{attribute}=")
        end
        obj
      end

      ##
      # Create an instance of +cls+ using provided +params+ to fill in attributes
      def instance_from_params(cls, params)
        n = cls.new
        populate_from_params(n, params)
      end

      ##
      # Serialize objects using a custom serializer that handles content negotiation
      # using the Accept header and "format" query string parameter
      # The method has two options parameters:
      #   +status (Fixnum)+: Status code to use in response
      #   +obj (Object)+: The object to serialize
      # Usage: +reply object+, +reply 201, object+
      def reply(*response)
        status = response.shift
        if !status.instance_of?(Fixnum)
          response.unshift status
          status = 200
        end

        obj = response.shift
        halt 404 if obj.nil? || obj.length == 0
        SERIALIZER.build_response(@env, status: status, ld_object: obj)
      end

      ##
      # Override the halt method provided by Sinatra to set the response appropriately
      def halt(*response)
        status, headers, obj = nil
        obj = response.first if response.length == 1
        if obj.instance_of?(Fixnum)
          # This is a status-only response
          status = obj
          obj = nil
        end
        status, obj = response.first, response.last if response.length == 2
        status, headers, obj = response.first, response[1], response.last if response.length == 3
        super(SERIALIZER.build_response(@env, status: status, headers: headers, ld_object: obj))
      end

      ##
      # Create an error response body by wrapping a message in a common hash structure
      # Call by providing an error code and then message or just a message:
      #   +error "Error message"+
      #   +error 400, "Error message"+
      def error(*message)
        status = message.shift
        if !status.instance_of?(Fixnum)
          message.unshift status
          status = 500
        end
        halt status, { :errors => message, :status => status }
      end

    end

    helpers ApplicationHelper
  end
end