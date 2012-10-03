require 'sinatra/base'

module Sinatra
  module Helpers
    module ApplicationHelper
      def h(text)
        Rack::Utils.escape_html(text)
      end
    end

    helpers ApplicationHelper
  end
end