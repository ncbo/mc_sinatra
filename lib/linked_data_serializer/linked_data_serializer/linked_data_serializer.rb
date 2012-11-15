require_relative "linked_data_media_types"

class LinkedDataSerializer
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    # Get params
    params = env["rack.request.query_hash"]
    # Client accept header
    accept = env['rack-accept.request']
    # Out of the media types we offer, which would be best?
    best = LinkedDataMediaTypes.base_type(accept.best_media_type(LinkedDataMediaTypes.all))
    # If user provided a format, override the accept header
    best = params["format"].to_sym if params["format"]
    # Generate the body using appropriate serializer
    body = serialize(best, response, params)
    # Set proper content length
    headers["Content-Length"] = body.bytesize.to_s
    [status, headers, body]
    # Error out if we don't support the foramt
    unless LinkedDataMediaTypes.supported_base_type?(best)
      return response(:status => 415)
    end
  end

  private

  def serialize(type, obj, params)
    only = params[:include] ||= []
    options = {:only => only}
    send("serialize_#{type}", obj, options)
  end

  def serialize_json(obj, options = {})
    obj.to_flex_hash(options).to_json
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