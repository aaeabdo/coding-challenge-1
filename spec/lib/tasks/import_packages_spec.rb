require 'spec_helper'
require 'rake'

describe 'general import_packages rake task' do
  include StdoutHelpers

  subject(:call_task) do
    rake[task_name].invoke
  end

  let(:logger)        { instance_double('Logger') }
  let(:package_model) { instance_double('Package') }
  let(:logic_klasses) do
    instance_double('Logic::Package::Importer::LogicKlasses')
  end
  let(:configurations) do
    instance_double('Logic::Package::Importer::Configurations')
  end
  let(:server_dir)                { 'http://cran.r-project.org/src/contrib/' }
  let(:packages_file_name)        { 'PACKAGES' }
  let(:package_location_template) { '{server_dir}{package_name}_{package_version}.tar.gz' }
  let(:description_file_name)     { 'DESCRIPTION' }
  let(:packages_limit)            { '5' }

  let(:rake) { Rake::Application.new }
  let(:task_name) do
    "general:import_packages"
  end
  let!(:temp_argv) { ARGV }

  let(:task_args) do
    [
      task_name,
      '--',
      '-s',
      server_dir,
      '-p',
      packages_file_name,
      '-t',
      package_location_template,
      '-d',
      description_file_name,
      '-l',
      packages_limit
    ]
  end

  before do
    stub_const('ARGV', task_args)
    allow(Logger).to receive(:new).with(STDOUT).and_return(logger)
    Rake.application = rake
    load 'lib/tasks/import_packages.rake'
    Rake::Task[task_name].reenable
  end

  context 'success' do
    context 'without args' do
      let(:task_args) { [] }
      let(:info_output) do
        <<~OUTPUT
          Usage: rake general:import_packages [options]
              -s, --one ARG                    server directory
              -p, --pfn ARG                    packages file name
              -t, --plt ARG                    packages location template
              -d, --dfn ARG                    description file name
              -l, --pl ARG                     packages limit
              -h, --help                       Print help
        OUTPUT
      end

      it 'prints help text' do
        output = capture_stdout do
          expect { call_task }.to raise_exception(SystemExit) do |e|
            expect(e.status).to eq(0)
          end
        end

        expect(output).to eq(info_output)
      end
    end

    context 'with args' do
      it 'calls importer' do
        expect(Logic::Package::Importer::LogicKlasses)
          .to receive(:new)
          .with(
            Logic::Package::PackagesFileGetter,
            Logic::Package::PackagesFileParser,
            Logic::Package::PackageLocationBuilder,
            Logic::Package::PackageGetter,
            Logic::Package::DescriptionFileGetter,
            Logic::Package::DescriptionFileParser,
            Logic::Package::InformationExtractor,
            Logic::Package::Creator
          )
          .and_return(logic_klasses)
        expect(Logic::Package::Importer::Configurations)
          .to receive(:new)
          .with(
            HTTP::Client,
            Decompressor::TarGzFile,
            DCF::YamlParser,
            DCF::TreetopParser,
            server_dir,
            packages_file_name,
            package_location_template,
            description_file_name,
            packages_limit.to_i
          )
          .and_return(configurations)
        expect(Logic::Package::Importer)
          .to receive(:call)
          .with(
            Package,
            logic_klasses,
            configurations
          )
          .and_return(true)

        expect(logger)
          .to receive(:info)
          .with('Started importing packages')
        expect(logger)
          .to receive(:info)
          .with("completed importing #{packages_limit} packages")

        expect { call_task }.to raise_exception(SystemExit) do |e|
          expect(e.status).to eq(0)
        end
      end
    end
  end

  context 'failure' do
    it 'reports an error' do
      expect(Logic::Package::Importer::LogicKlasses)
        .to receive(:new)
        .and_raise('simulated failure')
      expect(logger)
        .to receive(:info)
        .with('Started importing packages')
      expect(logger)
        .to receive(:error)
        .with("An error occured: simulated failure")

      expect { call_task }.to raise_exception(SystemExit) do |e|
        expect(e.status).to eq(1)
      end
    end
  end
end
