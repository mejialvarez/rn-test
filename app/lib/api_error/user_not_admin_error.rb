class ApiError::UserNotAdminError < ApiError::CustomError
  def initialize
    super(403, :forbidden, "Resource only for admin user")
  end
end