$LOAD_PATH.unshift File.expand_path("../../../lib/service_component", __FILE__)

class Requires
	def self.require_files
	  require "test/orchestration_provider_registry"
	  require "test/base_orchestration_provider"
	  Dir.glob(File.expand_path("../../../lib/service_component/test/**/*.rb", __FILE__), &method(:require))
	end
end