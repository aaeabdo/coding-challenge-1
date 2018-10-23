require 'spec_helper'
require_relative '../../../logic/package/package_location_builder'

RSpec.describe Logic::Package::PackageLocationBuilder do
  subject(:call) { described_class.call(package_location_template, server_dir, package_hash) }

  let(:package_location_template) { '{server_dir}{package_name}_{package_version}.tar.gz' }
  let(:server_dir)                { 'http://www.example.com/' }
  let(:package_hash) do
    {
      "Package"          => "A3",
      "Version"          => "1.0.0",
      "Depends"          => "R (>= 2.15.0), xtable, pbapply",
      "Suggests"         => "randomForest, e1071",
      "License"          => "GPL (>= 2)",
      "NeedsCompilation" => false
    }
  end

  context '.call' do
    let(:result) { 'http://www.example.com/A3_1.0.0.tar.gz' }

    it 'runs successfully' do
      expect(call).to eq result
    end
  end
end
