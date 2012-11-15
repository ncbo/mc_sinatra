class LinkedDataMediaTypes
  TYPE_MAP = {
     "text/html" => :html,
     "application/xhtml+xml" => :html,
     "application/json" => :json,
     "application/rdf+turtle" => :turtle,
     "application/x-turtle" => :turtle,
     "application/turtle" => :turtle,
     "application/rdf+xml" => :xml,
     "application/xml" => :xml,
     "text/xml" => :xml
  }

  DEFAULT_TYPES = {
    :html => "text/html",
    :turtle => "application/rdf+turtle",
    :xml => "application/rdf+xml",
    :json => "application/json"
  }

  def self.all
    TYPE_MAP.keys
  end

  def self.base_type(type)
    TYPE_MAP[type]
  end

  def self.media_type_from_base(type)
    DEFAULT_TYPES[type]
  end

  def self.supported_base_type?(type)
    DEFAULT_TYPES.key?(type.to_sym)
  end

  def self.supported_type?(type)
    TYPE_MAP.key?(type.to_s)
  end
end
