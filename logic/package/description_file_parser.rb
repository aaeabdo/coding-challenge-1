module Logic
  module Package
    class DescriptionFileParser
      def self.call(parser, description_file_content)
        parser.call(description_file_content).first
      end
    end
  end
end
