class HelloController < ApplicationController
  namespace "/hello" do
    get do
      "Hello world"
    end

    get '/debug' do
      LOGGER.debug "Let's start a debug session"
      # Start a debugging session using pry
      # This will put a breakpoint here. Type 'quit' at the console to resume.
      # Type 'help' at the console to get a list of commands.
      binding.pry
      "Debug session ended".to_json
    end

    get do
      # The 'h' method comes from the application_helper.rb file
      h("Hello world").to_json
    end

    get '/:name' do
      p = Person.new(params[:name])
      hello_message(p).to_json
    end

    get '/:name/day/:adjective' do
      p = Person.new(params[:name], params[:adjective])
      hello_message_day(p).to_json
    end
  end
end