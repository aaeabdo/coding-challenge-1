module Logic
  module Package
    class LogicError < StandardError
      attr_reader :original_exeption, :message
      def initialize(original_exeption, message)
        @original_exeption = original_exeption
        @message           = message
      end

      def to_s
        message
      end
    end
  end
end

require_relative 'package/packages_file_getter'
require_relative 'package/packages_file_parser'
require_relative 'package/package_location_builder'
require_relative 'package/package_getter'
require_relative 'package/description_file_getter'
require_relative 'package/description_file_parser'
require_relative 'package/information_extractor'
require_relative 'package/importer'
require_relative 'package/creator'
