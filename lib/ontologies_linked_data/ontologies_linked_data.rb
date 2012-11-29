require "goo"
require_relative "lib/serializer"

# Setup Goo
vocabs = Goo::Naming::Vocabularies.new()

# Any property no defined in a prefix space
# will fall under this namespace
vocabs.default = "http://data.bioontology.org/metadata/"

vocabs.register(:metadata, "http://data.bioontology.org/metadata/", bp_properties)

Goo::Naming.register_vocabularies(vocabs)