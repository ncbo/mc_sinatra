require "goo"
require_relative "lib/serializer"
require_relative "lib/monkeypatches/to_flex_hash/object"

# Require all models
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/lib/models/*', &method(:require))

# Setup Goo (repo connection and namespaces)
if Goo.store().nil?
  Goo.configure do |conf|
    conf[:stores] = [ { :name => :main , :host => "localhost", :port => 8000 , :options => { } } ]
    conf[:namespaces] = {
      :metadata => "http://data.bioontology.org/metadata/",
      :default => :metadata,
    }
  end
end

# # Setup Goo
# vocabs = Goo::Naming::Vocabularies.new()

# # Any property no defined in a prefix space
# # will fall under this namespace
# vocabs.default = "http://data.bioontology.org/metadata/"

# vocabs.register(:metadata, "http://data.bioontology.org/metadata/", [])
# vocabs.register_model(:metadata, :review, LinkedData::Models::Review)
# vocabs.register_model(:metadata, :ontology, LinkedData::Models::Ontology)
# vocabs.register_model(:metadata, :user, LinkedData::Models::User)

# Goo::Naming.register_vocabularies(vocabs)