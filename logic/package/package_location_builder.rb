module Logic
  module Package
    class PackageLocationBuilder
      # TODO: better error handling
      def self.call(package_location_template, server_dir, package_hash)
        package_location_template
          .gsub('{server_dir}', server_dir)
          .gsub('{package_name}', package_hash.fetch('Package'))
          .gsub('{package_version}', package_hash.fetch('Version').to_s)
      end
    end
  end
end
