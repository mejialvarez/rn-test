class ApiError::InvalidCredentialError < ApiError::CustomError
  def initialize
    super(401, :unauthorized, "Email or password invalid")
  end
end