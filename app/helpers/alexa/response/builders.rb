# Should provide necessary functionality to generate various responses for Alexa.
# See https://developer.amazon.com/docs/custom-skills/request-and-response-json-reference.html#response-format
#
# Contains kinda low and high level functions.
# Low level functions are defining response fragments. Like +output_speech+
#
# High level functions should return the actual JSON payload.
# Use +main_carcass+ to construct the final response. It also includes :json key for Rails'es renderer.
#
# The list is not completed. So you may add some more :)
#
module Alexa
  module Response
    module Builders

      # Builds basic response data with given +message+ to be recorded by Alexa
      def plain_text_response(message, end_session = true)
        main_carcass output_speech(message), end_session
      end

      # Builds response with given +message+ and a link account card.
      # Sets +shouldEndSession+ true.
      def link_account_card_response(message)
        main_carcass output_speech(message).merge(link_account_card), true
      end

      private
      def output_speech(text)
        { outputSpeech: {
            type: :PlainText,
            text: text } }
      end

      # This is a special type of card that tells the user to link their account.
      # When displayed in the Alexa app, this card displays a link to your authorization URI.
      # The user can start the account linking process right from this card.
      #
      # Use this card with appropriate speech text.
      # Ex.
      #   You must have a Car Fu account to order a car. Please use the Alexa
      #   app to link your Amazon account with your Car Fu Account.
      def link_account_card
        { card: { type: :LinkAccount } }
      end

      # Builds the JSON response skeleton for Alexa
      def main_carcass(body, end_session = true, session_attributes = {})
        { json: {
            version: '1.0',
            sessionAttributes: session_attributes,
            response: body,
            shouldEndSession: end_session }}
      end
    end
  end
end
