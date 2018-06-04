class API::V1::Alexa::BaseController < ActionController::API
  include ::Alexa::RequestValidators::Base
  respond_to :json

  before_action :validate_request!

  def say_hi
    puts JSON.parse(params.to_json).to_yaml

    message = 'Hi my lord!'
    session_attributes = {previous_session: 'something'}
    session_end = true

    render json: {
      response: {
        outputSpeech: {
          type: :PlainText,
          text: message,
        },
        shouldEndSession: session_end
      },
      sessionAttributes: session_attributes
    }
  end

end
