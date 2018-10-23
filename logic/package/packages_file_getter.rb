module Logic
  module Package
    class PackagesFileRetrievalError < LogicError; end
    class PackagesFileGetter
      def self.call(client, server_dir, packages_file_name)
        packages_location = server_dir + packages_file_name

        begin
          response          = client.get(packages_location)
        rescue StandardError => e
          raise PackagesFileRetrievalError.new(e, 'Failed to retrieve packages file')
        end

        if response.error?
         raise PackagesFileRetrievalError.new(
           nil,
           "Failed to retrieve packages file, received response with http "\
           "status: #{response.code}"
         )
        end

        response.body
      end
    end
  end
end


