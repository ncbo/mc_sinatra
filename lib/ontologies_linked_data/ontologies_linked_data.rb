require "goo"
require_relative "lib/serializer"
require_relative "lib/monkeypatches/to_flex_hash/object"

# Require all models
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/lib/models/*', &method(:require))

# Setup Goo (repo connection and namespaces)
module LinkedData
  def self.config(options = {})
    port = options[:port] || GOO_PORT || 9000
    host = options[:host] || GOO_HOST || "localhost"
    begin
      Goo.configure do |conf|
        conf[:stores] = [ { :name => :main , :host => host, :port => port, :options => { } } ]
        conf[:namespaces] = {
          :metadata => "http://data.bioontology.org/metadata/",
          :default => :metadata,
        }
      end
    rescue Exception => e
      puts "Invalid configuration, moving on"
    end
  end
end