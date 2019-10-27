# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('./movie_booking'))
$LOAD_PATH.unshift(File.expand_path('./movie_booking/spec'))
$LOAD_PATH.unshift(File.expand_path(__dir__))

require 'boot'
require 'environment'

Bundler.require :default, ENV['RACK_ENV']

require 'config'
require 'database'
require 'application_contract'
require 'constants_autoloading'

require 'api'
require 'app'
