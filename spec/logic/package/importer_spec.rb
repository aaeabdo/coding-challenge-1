require 'spec_helper'
require_relative '../../../logic/package/importer'

RSpec.describe Logic::Package::Importer do
  subject(:call) { described_class.call(package_model, logic_klasses, configurations) }

  let(:package_model) { instance_double('Package') }
  let(:logic_klasses) do
    instance_double(
      'Logic::Package::Importer::LogicKlasses',
      packages_file_getter:     packages_file_getter,
      packages_file_parser:     packages_file_parser,
      package_location_builder: package_location_builder,
      package_getter:          package_getter,
      description_file_getter:  description_file_getter,
      description_file_parser:  description_file_parser,
      information_extractor:    information_extractor,
      creator:                  creator
    )
  end
  let(:packages_file_getter)     { class_double('Logic::Package::PackagesFileGetter') }
  let(:packages_file_parser)     { class_double('Logic::Package::PackagesFileParser') }
  let(:package_location_builder) { class_double('Logic::Package::PackageLocationBuilder') }
  let(:package_getter)           { class_double('Logic::Package::PackageGetter') }
  let(:description_file_getter)  { class_double('Logic::Package::DescriptionFileGetter') }
  let(:description_file_parser)  { class_double('Logic::Package::DescriptionFileParser') }
  let(:information_extractor)    { class_double('Logic::Package::InformationExtractor') }
  let(:creator)                  { class_double('Logic::Package::Creator') }

  let(:configurations) do
    instance_double(
      'Logic::Package::Importer::Configurations',
      client:                    client,
      decompressor:              decompressor,
      packages_parser:           packages_parser,
      description_parser:        description_parser,
      server_dir:                server_dir,
      packages_file_name:        packages_file_name,
      package_location_template: package_location_template,
      description_file_name:     description_file_name,
      packages_limit:            packages_limit
    )
  end
  let(:client)                    { class_double("HTTP::Client")}
  let(:decompressor)              { class_double("Decompressor::TarGzFile")}
  let(:packages_parser)           { class_double("DCF::YamlParser")}
  let(:description_parser)        { class_double("DCF::TreetopParser")}
  let(:server_dir)                { double('server_dir') }
  let(:packages_file_name)        { double('packages_file_name') }
  let(:package_location_template) { double('package_location_template') }
  let(:description_file_name)     { double('description_file_name') }
  let(:packages_limit)            { double('packages_limit') }

  let(:packages_file) { double('package_file') }
  let(:packages_hashes) do
    [
      package_hash,
      package_hash
    ]
  end
  let(:package_hash)        { double('package_hash') }
  let(:package_location)    { double('package_location') }
  let(:package_content)     { double('package_content') }
  let(:description_file)    { double('description_file') }
  let(:package_description) { double('package_description') }
  let(:package_to_create)   { double('package_to_create') }

  context '.call' do
    let(:result) { packages_hashes }

    it 'runs successfully' do
      expect(packages_file_getter)
        .to receive(:call)
        .with(client, server_dir, packages_file_name)
        .and_return(packages_file)

      expect(packages_file_parser)
        .to receive(:call)
        .with(packages_parser, packages_file, packages_limit)
        .and_return(packages_hashes)

      expect(package_location_builder)
        .to receive(:call)
        .with(package_location_template, server_dir, package_hash)
        .twice
        .and_return(package_location)

      expect(package_getter)
        .to receive(:call)
        .with(client, package_location)
        .twice
        .and_return(package_content)

      expect(description_file_getter)
        .to receive(:call)
        .with(decompressor, package_content, description_file_name)
        .twice
        .and_return(description_file)

      expect(description_file_parser)
        .to receive(:call)
        .with(description_parser, description_file)
        .twice
        .and_return(package_description)

      expect(information_extractor)
        .to receive(:call)
        .with(package_description)
        .twice
        .and_return(package_to_create)

      expect(creator)
        .to receive(:call)
        .with(package_model, package_to_create)
        .twice
        .and_return(result)

      expect(call).to eq result
    end
  end
end
