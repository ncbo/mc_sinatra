GOO_PORT = 9000
GOO_HOST = "localhost"

# Settings in this file can be overridden in the custom.rb (warnings may happen)
require_relative "custom.rb" if File.exist?("custom.rb")
