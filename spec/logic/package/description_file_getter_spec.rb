require 'spec_helper'
require_relative '../../../logic/package/description_file_getter'

RSpec.describe Logic::Package::DescriptionFileGetter do
  subject(:call) { described_class.call(decompressor, package_content, description_file_name) }

  let(:decompressor)          { class_double('Decompressor::TarGzFile') }
  let(:package_content)       { double('package_content') }
  let(:description_file_name) { double('description_file_name') }

  context '.call' do
    let(:result) { double('result') }

    it 'runs successfully' do
      expect(decompressor)
        .to receive(:call)
        .with(package_content, description_file_name)
        .and_return(result)

      expect(call).to eq result
    end
  end
end
