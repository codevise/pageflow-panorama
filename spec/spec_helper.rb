ENV['RAILS_ENV'] ||= 'test'
ENV['PAGEFLOW_PLUGIN_ENGINE'] = 'pageflow_panorama'

require 'pageflow/support'
Pageflow::Dummy.setup

require 'rspec/rails'

engine_root = File.join(File.dirname(__FILE__), '..')
Dir[File.join(engine_root, 'spec/support/**/*.rb')].each { |file| require(file) }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end
