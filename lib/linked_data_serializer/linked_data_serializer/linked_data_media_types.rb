class LinkedDataMediaTypes
  TYPE_MAP = {
     "application/rdf+turtle" => :turtle,
     "application/x-turtle" => :turtle,
     "application/turtle" => :turtle,
     "application/json" => :json,
     "application/rdf+xml" => :xml,
     "application/xml" => :xml,
     "text/xml" => :xml,
     "text/html" => :html,
     "application/xhtml+xml" => :html
  }

  def self.all
    TYPE_MAP.keys
  end

  def self.symbol(type)
    TYPE_MAP[type]
  end
end
