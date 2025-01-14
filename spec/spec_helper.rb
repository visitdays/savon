# frozen_string_literal: true
require "bundler"
Bundler.setup(:default, :development)

unless RUBY_PLATFORM =~ /java/
  require "simplecov"
  require "coveralls"

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
      add_filter "spec"
  end
end

require "savon"
require "rspec"

# don't have HTTPI lazy-load HTTPClient, because then
# it can't actually be refered to inside the specs.
require "httpclient"

support_files = File.expand_path("spec/support/**/*.rb")
Dir[support_files].each { |file| require file }

RSpec.configure do |config|
  config.include SpecSupport
  config.mock_with :mocha
  config.order = "random"
end

HTTPI.log = false


Bundler.require :default, :development

def fixture(local_path)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', local_path))
end
