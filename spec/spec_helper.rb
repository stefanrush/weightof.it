ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[
  Rails.root.join('spec/support/**/*.rb'),
  Rails.root.join('spec/concerns/**/*.rb')
].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.use_instantiated_fixtures  = false
  config.mock_with :rspec
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
  
  config.include FactoryGirl::Syntax::Methods
end

ActiveRecord::Migration.maintain_test_schema!
