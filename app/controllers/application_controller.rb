class ApplicationController < ActionController::API
  protect_from_forgery with: :null_session

  respond_to :json

  before_action :underscore_params!

  private
  def underscore_params!
    params.deep_transform_keys! &:underscore
  end
end
