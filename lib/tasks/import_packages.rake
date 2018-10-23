require 'optparse'
require_relative '../../logic/package'
require_relative '../dcf'
require_relative '../http/client'
require_relative '../decompressor/tar_gz_file'
require_relative '../../service'

namespace :general do
  task :import_packages do
    parsed_args = {}
    opts = OptionParser.new
    opts.banner = "Usage: rake general:import_packages [options]"
    opts.on("-s", "--one ARG", String, 'server directory') { |sd| parsed_args[:server_dir] = sd }
    opts.on("-p", "--pfn ARG", String, 'packages file name') do |pfn|
      parsed_args[:packages_file_name] = pfn
    end
    opts.on("-t", "--plt ARG", String, 'packages location template') do |plt|
      parsed_args[:package_location_template] = plt
    end
    opts.on("-d", "--dfn ARG", String, 'description file name') do |dfn|
      parsed_args[:description_file_name] = dfn
    end
    opts.on("-l", "--pl ARG", Integer, 'packages limit') do |pl|
      parsed_args[:packages_limit] = pl
    end

    opts.on_tail('-h', '--help', 'Print help') do
      puts opts
      exit(0)
    end

    ARGV << '-h' if ARGV.empty?
    args = opts.order!(ARGV) {}
    opts.parse!(args)

    # TODO: informative logs ...
    begin
      logger = Logger.new(STDOUT)
      logger.info('Started importing packages')
      logic_klasses = Logic::Package::Importer::LogicKlasses.new(
        Logic::Package::PackagesFileGetter,
        Logic::Package::PackagesFileParser,
        Logic::Package::PackageLocationBuilder,
        Logic::Package::PackageGetter,
        Logic::Package::DescriptionFileGetter,
        Logic::Package::DescriptionFileParser,
        Logic::Package::InformationExtractor,
        Logic::Package::Creator
      )

      configurations = Logic::Package::Importer::Configurations.new(
        HTTP::Client,
        Decompressor::TarGzFile,
        DCF::YamlParser,
        DCF::TreetopParser,
        parsed_args.fetch(:server_dir),
        parsed_args.fetch(:packages_file_name),
        parsed_args.fetch(:package_location_template),
        parsed_args.fetch(:description_file_name),
        parsed_args.fetch(:packages_limit)
      )

      Logic::Package::Importer.call(
        Package,
        logic_klasses,
        configurations
      )
    rescue StandardError => e
      logger.error("An error occured: #{e.to_s}")
      exit(1)
    else
      logger.info("completed importing #{parsed_args.fetch(:packages_limit)} packages")
    end

    exit(0)
  end
end
