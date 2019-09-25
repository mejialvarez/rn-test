class ApiError::CustomError < StandardError
  attr_reader :code, :reason, :message

  def initialize(code=nil, reason=nil, message=nil)
    @code = code || 422
    @reason = reason || :unprocessable_entity
    @message = message || 'Something went wrong'
  end
end
