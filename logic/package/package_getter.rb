module Logic
  module Package
    class PackageRetrievalError < LogicError; end
    class PackageGetter
      def self.call(client, package_location)
        begin
          response = client.get(package_location)
        rescue StandardError => e
          raise PackageRetrievalError.new(e, 'Failed to retrieve package')
        end

        if response.error?
         raise PackageRetrievalError.new(
           nil,
           "Failed to retrieve package, received response with http "\
           "status: #{response.code}"
         )
        end

        response.raw_body
      end
    end
  end
end
