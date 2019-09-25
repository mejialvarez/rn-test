class Api::V1::AuthenticationController < ApplicationController
  def auth
    user = User.find_by_email(params[:email])
    raise ApiError::InvalidCredentialError unless user&.authenticate(params[:password])

    token = JsonWebToken.encode(user_id: user.id)
    time = Time.current + 24.hours.to_i

    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
  end
end