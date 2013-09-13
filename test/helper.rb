require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/colorize'
require 'mocha/setup'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'mush'
