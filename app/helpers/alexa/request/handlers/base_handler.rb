module Alexa
  module Request
    module Handlers
      class BaseHandler
        attr_reader :user

        def initialize(user)
          @user = user
        end

        # Check if the request is authorized
        def authorized?
          user.present?
        end
      end
    end
  end
end
