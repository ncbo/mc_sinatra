require_relative "linked_data_media_types"

class LinkedDataSerializer
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    LOGGER.debug "WE'RE HERE"
    # Client accept header
    accept = env['rack-accept.request']
    # Out of the media types we offer, which would be best?
    best = accept.best_media_type(LinkedDataMediaTypes.all)
    body = serialize(LinkedDataMediaTypes.symbol(best), response)
    binding.pry
    [status, headers, body]
  end

  private

  def serialize(type, obj)
    send("serialize_#{type}", obj)
  end

  def serialize_json(obj)
    obj.to_json
  end

  def serialize_html(obj)
    "html"
  end

  def serialize_xml(obj)
    "xml"
  end

  def serialize_turtle(obj)
    "turtle"
  end
end