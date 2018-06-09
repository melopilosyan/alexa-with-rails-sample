# See https://developer.amazon.com/docs/custom-skills/request-types-reference.html
#
module Alexa
  module Request
    module Handlers
      class RequestType < ::String
        LAUNCH             = 'LaunchRequest'.freeze
        INTENT             = 'IntentRequest'.freeze
        SESSION_END        = 'SessionEndedRequest'.freeze
        CAN_FULFILL_INTENT = 'CanFulfillIntentRequest'.freeze

        def launch?
          self == LAUNCH
        end

        def intent?
          self == INTENT
        end

        def session_end?
          self == SESSION_END
        end

        def can_fulfill_intent?
          self == CAN_FULFILL_INTENT
        end
      end
    end
  end
end
