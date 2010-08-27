require 'httparty'
require 'mush/errors'
require 'mush/service'
require 'mush/authenticated_service'

Dir[File.dirname(__FILE__)+"/mush/services/*"].each { |service| require service }

module Mush
  def self.version
    File.read(File.join(File.dirname(__FILE__), *%w[.. VERSION]))
  end
end