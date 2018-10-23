module Logic
  module Package
    class Importer
      LogicKlasses = Struct.new(
        :packages_file_getter,
        :packages_file_parser,
        :package_location_builder,
        :package_getter,
        :description_file_getter,
        :description_file_parser,
        :information_extractor,
        :creator
      )

      Configurations = Struct.new(
        :client,
        :decompressor,
        :packages_parser,
        :description_parser,
        :server_dir,
        :packages_file_name,
        :package_location_template,
        :description_file_name,
        :packages_limit
      )

      # TODO: better error handling
      def self.call(
        package_model,
        logic_klasses,
        configurations
      )
        packages_file = logic_klasses
          .packages_file_getter
          .call(
            configurations.client,
            configurations.server_dir,
            configurations.packages_file_name
          )

        packages_hashes = logic_klasses.packages_file_parser.call(
          configurations.packages_parser,
          packages_file,
          configurations.packages_limit
        )

        packages_hashes.each do |package_hash|
          begin
            package_location = logic_klasses.package_location_builder.call(
              configurations.package_location_template,
              configurations.server_dir,
              package_hash
            )
            package_content = logic_klasses
              .package_getter
              .call(
                configurations.client,
                package_location
              )
            description_file = logic_klasses
              .description_file_getter
              .call(
                configurations.decompressor,
                package_content,
                configurations.description_file_name
              )
            package_description = logic_klasses
              .description_file_parser
              .call(
                configurations.description_parser,
                description_file
              )
            package_to_create = logic_klasses
              .information_extractor
              .call(package_description)
            logic_klasses
              .creator
              .call(package_model, package_to_create)
          rescue StandardError # TODO: concise error handling and logging
            next
          end
        end
      end
    end
  end
end
