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
    # Generate the body using appropriate serializer
    body = serialize(LinkedDataMediaTypes.symbol(best), response)
    # Set proper content length
    headers["Content-Length"] = body.bytesize.to_s
    binding.pry
    [status, headers, body]
  end

  private

  def serialize(type, obj)
    only = params[:include] ||= []
    options = {:only => only}
    send("serialize_#{type}", obj, options)
  end

  def serialize_json(obj, options = {})
    obj.to_hash(options).to_json
  end

  def serialize_html(obj, options = {})
    "html"
  end

  def serialize_xml(obj, options = {})
    "xml"
  end

  def serialize_turtle(obj, options = {})
    "turtle"
  end
end