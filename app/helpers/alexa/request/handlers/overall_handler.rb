# Delegates the request handling to appropriate classes specialized by request types
#
# Specified blocks to all +on_###_request+ functions should return
# completed response JSON data. Use response builders to do that.
# app/helpers/alexa/response/builders.rb
#
module Alexa
  module Request
    module Handlers
      class OverallHandler < BaseHandler
        include Alexa::Request::Parsers

        attr_reader :params, :request_type, :response

        def initialize(params, user)
          @params = params
          @request_type = RequestType.new fetch_by_steps(:request, :type).to_s

          super(user)
        end

        # The block should return the response JSON data in case of not authorized
        # requests. If the request is not authorized other +on_###_request+ functions
        # simple will drop their blocks and this data will be send to Alexa.
        def on_unauthorized_request
          if block_given? && !authorized?
            @response = yield
          end
        end


        # LaunchRequest is a simple type of request.
        # It doesn't need its own handler class
        def on_launch_request
          if authorized? && request_type.launch? && block_given?
            @response = yield user
          end
        end

        # IntentRequest type is not so simple as LaunchRequest is.
        # Here need to pass to the block an instance of IntentHandler class with
        # suitable functionality to deal with the request, rather than the user object.
        def on_intent_request
          if authorized? && request_type.intent? && block_given?
            @response = yield user
          end
        end

        def on_session_end_request
          if authorized? && request_type.session_end? && block_given?
            # yield the block passing the argument of corresponding handler class instance
          end
        end

        def on_can_fulfill_intent_request
          if authorized? && request_type.can_fulfill_intent? && block_given?
            # yield the block passing the argument of corresponding handler class instance
          end
        end
      end
    end
  end
end
