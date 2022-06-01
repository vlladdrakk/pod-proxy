require 'rubygems'
require 'bundler'

Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

Bundler.require

require './App'
run Sinatra::Application
