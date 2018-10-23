module Logic
  module Package
    class DescriptionFileGetter
      def self.call(decompressor, package_content, description_file_name)
        decompressor.call(package_content, description_file_name)
      end
    end
  end
end
