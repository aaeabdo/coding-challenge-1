module Logic
  module Package
    class PackagesFileParser
      def self.call(parser, packages_file_content, packages_limit)
        parser.call(packages_file_content, packages_limit)
      end
    end
  end
end
