# Declares top level request handler functionality
#
module Alexa
  module Request
    module Handlers

      def handle_alexa_request
        if block_given?
          yield alexa_request_handler

          render alexa_request_handler.response
        else
          # Some Error message goes here
        end
      end

      private
      def alexa_request_handler
        @alexa_request_handler ||= OverallHandler.new(params, current_doorkeeper_user)
      end

      def current_doorkeeper_user
        @current_doorkeeper_user = if valid_doorkeeper_token?
          User.find_by_id doorkeeper_token.resource_owner_id
        else
          nil
        end
      end
    end
  end
end
