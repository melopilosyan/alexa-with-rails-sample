# Should provide solid logic to validate requests from AWS Alexa
# See https://developer.amazon.com/docs/custom-skills/handle-requests-sent-by-alexa.html
#
module Alexa
  module RequestValidators
    module Base
      include ApplicationValidator

      def validate_request!
        valid = validate_application

        render json: {msg: 'Go fix yourself!'}, status: :bad_request unless valid
      end
    end
  end
end
