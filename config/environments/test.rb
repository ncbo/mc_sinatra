

local_path = File.expand_path("../local/development.rb", __FILE__)
require local_path if File.exist?(local_path)