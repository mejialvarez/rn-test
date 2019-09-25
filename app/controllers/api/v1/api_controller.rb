class Api::V1::ApiController < ApplicationController
  def current_user
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)
    @current_user ||= User.find(decoded[:user_id])
  end

  def authenticate_user
    raise ApiError::UserNotAuthenticatedError unless current_user
  end

  def require_admin
    raise ApiError::UserNotAdminError unless current_user.admin?
  end
end
