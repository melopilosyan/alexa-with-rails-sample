# Should provide handy functionality to get data from Alexa JSON request.
# See https://developer.amazon.com/docs/custom-skills/request-and-response-json-reference.html#request-format
#
module Alexa
  module Request
    module Parsers

      def request_access_token
        fetch_by_steps :context, :System, :user, :accessToken
      end

      def request_intent_name
        fetch_by_steps :request, :intent, :name
      end

      # Try to get data under given keys structure.
      #
      # For example to get the +deviceId+ from this structure
      #   "context": {
      #     "System": {
      #       "device": {
      #         "deviceId": "string",
      #         "supportedInterfaces": {
      #           "AudioPlayer": {}
      #         }
      #       }
      #     }
      #   }
      # Call this function like:
      #   device_id = fetch_by_steps :context, :System, :device, :deviceId
      #
      # Returns +nil+ if some of the keys does not found under the previous one
      # otherwise the fetched data.
      def fetch_by_steps(*keys)
        last_key = keys.pop
        keys.inject(params) { |_params, key| _params.fetch key, {} }[last_key]
      end
    end
  end
end
