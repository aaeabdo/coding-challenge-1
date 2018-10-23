require_relative 'base'

module Representers
  class Errors
    def self.error_body(code, message, details = nil)
      error = {
        code:    code,
        message: message
      }

      error[:details] = details if details.present?

      error
    end

    def self.schema_validation_error(exception)
      exception_hash = exception.to_hash

      error_body(
        'invalid_format',
        'The request validation against the json schema failed',
        schema_errors: {
          failed_attribute: exception_hash[:failed_attribute],
          fragment:         exception_hash[:fragment],
          message:          exception.message
        }
      )
    end
  end
end
