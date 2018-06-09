# Validates the +applicationId+ provided as part of the +context+
# object in the +System+ section within JSON body of the request.
# This actually is the skill ID.
#
# Find your skills IDs on Alexa Skills developer page:
#   https://developer.amazon.com/alexa/console/ask
# and save the data in the config/alexa.yml under +SKILLS_IDS+ section with given format.
#
module Alexa
  module Request
    module Validators
      module SkillValidator

        def validate_skill
          drop_unless SKILLS_IDS.values.include? skill_id
        end

        private
        def skill_id
          fetch_by_steps :context, :System, :application, :applicationId
        end

        SKILLS_IDS = ALEXA_CONFIG['SKILLS_IDS']
      end
    end
  end
end
