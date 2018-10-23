module Representers
  class Base
    def self.member(member)
      member.to_h
    end

    def self.collection(collection)
      collection.map { |member| self.member(member) }
    end

    def self.validation_error(member)
      Errors.error_body(
        'invalid_argument',
        "#{member.class} not valid",
        'field_violations' => build_field_violations(member.errors)
      )
    end

    class << self
      private

      def build_field_violations(errors)
        field_violations = []

        errors.details.each do |field, field_errors|
          field_name = field.to_s

          field_errors.each do |field_error|
            field_violations << { field: field_name, code: field_error[:error] }
          end
        end

        field_violations
      end
    end
  end
end
