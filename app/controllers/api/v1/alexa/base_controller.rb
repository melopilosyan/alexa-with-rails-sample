class API::V1::Alexa::BaseController < ApplicationController
  respond_to :json

  def say_hi
    render json: {msg: :hi}
  end
end
