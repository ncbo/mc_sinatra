require 'sinatra/base'

module Sinatra
  module Helpers
    module MessageHelper
      def hello_message(person)
        "Hello #{person.name}"
      end

      def hello_message_day(person)
        "Hello #{person.name}, have a #{person.adjective} day!"
      end
    end

    helpers MessageHelper
  end
end