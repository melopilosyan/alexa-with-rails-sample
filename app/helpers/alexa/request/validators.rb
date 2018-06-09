# Should provide solid logic to validate Alexa's requests
# See https://developer.amazon.com/docs/custom-skills/handle-requests-sent-by-alexa.html
#
# You may need to add more validator modules. Do that in the format the +SkillValidator+ is.
#
module Alexa
  module Request
    module Validators
      include BaseValidator
      include SkillValidator
      # Include the rest of validators you'll add

      def validate_alexa_request!
        validate_skill
        # More +validate_###+ functions goes here. Well, kind of...
      end
    end
  end
end
