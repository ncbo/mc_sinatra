module LinkedData
  module MediaTypes
    HTML = :html
    JSON = :json
    XML = :xml
    TURTLE = :turtle

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

    private

    TYPE_MAP = {
       "text/html" => HTML,
       "application/xhtml+xml" => HTML,
       "application/json" => JSON,
       "application/rdf+turtle" => TURTLE,
       "application/x-turtle" => TURTLE,
       "application/turtle" => TURTLE,
       "application/rdf+xml" => XML,
       "application/xml" => XML,
       "text/xml" => XML
    }

    DEFAULT_TYPES = {
      HTML => "text/html",
      TURTLE => "application/rdf+turtle",
      XML => "application/rdf+xml",
      JSON => "application/json"
    }

  end
end