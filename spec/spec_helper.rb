PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
