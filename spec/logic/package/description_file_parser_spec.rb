require 'spec_helper'
require_relative '../../../logic/package/description_file_parser'

RSpec.describe Logic::Package::DescriptionFileParser do
  subject(:call) { described_class.call(parser, description_file_content) }

  let(:parser)                   { class_double('DCF::YamlParser') }
  let(:description_file_content) { double('description_file_content') }

  context '.call' do
    let(:result) { double('result') }

    it 'runs successfully' do
      expect(parser)
        .to receive(:call)
        .with(description_file_content)
        .and_return(result)

      expect(result).to receive(:first).and_return(result)

      expect(call).to eq result
    end
  end
end
