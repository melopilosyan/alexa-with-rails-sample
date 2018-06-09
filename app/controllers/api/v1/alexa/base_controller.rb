class API::V1::Alexa::BaseController < ActionController::API
  include ::Alexa

  respond_to :json

  prepend_before_action :set_access_token_in_params
  before_action :validate_alexa_request!


  def handler
    handle_alexa_request do |handler|
      handler.on_unauthorized_request do
        msg = 'I want to help you but we can only give information to authenticated users. ' +
              'Please connect your Alexa app with your RubyLabs account first.'

        plain_text_response msg
      end

      handler.on_launch_request do |user|
        msg = "Hello #{user.full_name}, is there anything you want to ask? " +
              'You can try: Alexa, ask ruby labs to generate a PDF or a CSV or an XLSX. ' +
              'Or you can check for the existing process state, like: Alexa, ask ruby labs to '+
              'check the process state. Or: Alexa, ask ruby labs to check if my PDF is available.'

        plain_text_response msg
      end

      handler.on_intent_request do |user|
        msg = case request_intent_name
          when 'DataGenerationIntent'
            # Of course before responding the server should run some backend tasks in this case
            "#{user.full_name}, your file is on its way. Try to check the state after some time. Like: " +
            'Alexa, ask ruby labs to check the process state'
          when 'DataCheckerIntent'
            "#{user.full_name}, we working hard to make you happy. It is ready"
          else
            "This case won't be. But anyway: hello #{user.full_name}"
        end

        plain_text_response msg
      end
    end
  end

  private
  def set_access_token_in_params
    request.parameters[:access_token] = request_access_token
  end
end
