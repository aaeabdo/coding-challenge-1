require 'spec_helper'
require_relative '../../../logic/package/packages_file_parser'

RSpec.describe Logic::Package::PackagesFileParser do
  subject(:call) { described_class.call(parser, packages_file_content, packages_limit) }

  let(:parser)                { class_double('DCF::YamlParser') }
  let(:packages_file_content) { double('description_file_content') }
  let(:packages_limit)        { double('packages_limit') }

  context '.call' do
    let(:result) { double('result') }

    it 'runs successfully' do
      expect(parser)
        .to receive(:call)
        .with(packages_file_content, packages_limit)
        .and_return(result)

      expect(call).to eq result
    end
  end
end
