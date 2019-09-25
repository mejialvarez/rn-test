class ApiError::UserNotAuthenticatedError < ApiError::CustomError
  def initialize
    super(401, :unauthorized, "User not logged in")
  end
end