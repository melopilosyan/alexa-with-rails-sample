# Declare base functionality for all request validators
#
module Alexa
  module Request
    module Validators
      module BaseValidator

        private
        def drop_unless(condition)
          # Respond with error code. So Alexa will not proceed further.
          render plain_text_response('Go fix yourself!'), status: :bad_request unless condition
        end
      end
    end
  end
end
