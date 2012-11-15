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

  def self.all
    TYPE_MAP.keys
  end

  def self.symbol(type)
    TYPE_MAP[type]
  end
end
