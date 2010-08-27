module Mush
  class InterfaceMethodNotImplementedError < StandardError; end
  class InvalidURI < ArgumentError; end
  class InvalidAuthorizationData < ArgumentError; end
  class InvalidAuthorizationFields < ArgumentError; end
end