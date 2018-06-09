# Load all Alexa helper modules
#
module Alexa
  include Request::Parsers
  include Request::Validators
  include Request::Handlers

  include Response::Builders

end
