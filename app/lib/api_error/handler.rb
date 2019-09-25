module ApiError
  module Handler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from StandardError do |e|
          Rails.logger.error(error_message(e.message))
          Rails.logger.error(e.backtrace.join("\n"))
          respond(500, :server_error, 'Something went wrong')
        end

        rescue_from ActionController::ParameterMissing do |e|
          Rails.logger.error(error_message(e.message))
          respond(422, :parameter_missing, e.message)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          Rails.logger.error(error_message(e.message))
          respond(404, :record_not_found, e.message)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          Rails.logger.error(error_message(e.message))
          respond(422, :record_invalid, e.message)
        end

        rescue_from JWT::DecodeError do |e|
          Rails.logger.error(error_message(e.message))
          respond(401, :unauthorized, e.message)
        end

        rescue_from CustomError do |e|
          Rails.logger.error(error_message(e.message))
          respond(e.code, e.reason, e.message)
        end
      end
    end

    private

      def respond(code, reason, message)
        render(
          json: {
            error: {
              code: code,
              reason: reason,
              message: message
            }
          },
          status: code
        )
      end

      def error_message(message)
        "Trying to use API, was raised the following exception: #{message}"
      end
  end
end
