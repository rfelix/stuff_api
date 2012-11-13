require 'rspec/given'
require 'json'
require_relative 'spec_helper'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  StuffServer.tap { |app|  }
end

#### General helper methods to help during tests

def parsed_json
  JSON.parse(last_response.body)
end

def show_me_the_response
  puts last_response.body
end

def show_me_the_json
  puts JSON.pretty_generate(parsed_json)
end

#### Collection+json specific helper methods

def collection_href
  parsed_json['collection']['href']
end
