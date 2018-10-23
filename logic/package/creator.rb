module Logic
  module Package
    class Creator
      # TODO: handle errors
      def self.call(package_model, package_hash)
        package = package_model.find_or_initialize_by(
          name:    package_hash[:name],
          version: package_hash[:version]
        )
        package.assign_attributes(package_hash)
        package.save!
      end
    end
  end
end
