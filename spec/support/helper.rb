module StdoutHelpers
  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = output = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    output.string
  end
end

require 'json-schema'

module Matchers
  RSpec::Matchers.define :be_valid_against_schema do |schema|
    match do |json|
      errors = JSON::Validator.fully_validate(
        "api_specifications/schemas/v1/responses/#{schema}.json",
        json,
        strict: true
      )
      errors.empty?
    end
  end
end
