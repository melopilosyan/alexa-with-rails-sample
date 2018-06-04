# Validates the +applicationId+ provided as part of the +session+
# object in the JSON body of the request
#
# This actually is the skill ID.
# Find your skill ID on Alexa Skills developer console page:
# https://developer.amazon.com/alexa/console/ask
#
module Alexa
  module RequestValidators
    module ApplicationValidator

      def validate_application
        SKILLS_IDS.values.include? params_application_id
      end

      private
      def params_application_id
        params.fetch(:session, {}).fetch(:application, {})[:applicationId]
      end

      SKILLS_IDS = ALEXA_CONFIG['SKILLS_IDS']
    end
  end
end
