require 'rspec/given'
require 'json'
require_relative 'spec_helper'
require_relative 'steps'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  StuffServer.tap { |app|  }
end
