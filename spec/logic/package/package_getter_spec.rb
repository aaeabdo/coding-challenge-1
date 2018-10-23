require 'spec_helper'
require_relative '../../../logic/package'

RSpec.describe Logic::Package::PackageGetter do
  subject(:call) { described_class.call(client, package_location) }

  let(:client)           { class_double('HTTP::Client') }
  let(:package_location) { double('package_location') }

  context '.call' do
    let(:response) { double('body', raw_body: raw_body, error?: error, code: code) }
    let(:raw_body) { double('raw_body') }
    let(:code)     { 200 }

    context 'success' do
      let(:error)    { false }

      it 'runs successfully' do
        expect(client)
          .to receive(:get)
          .with(package_location)
          .and_return(response)

        expect(call).to eq raw_body
      end
    end

    context 'failure' do
      let(:error) { true }
      let(:code)  { 500 }

      context 'http error' do
        it 'raises exception' do
          expect(client)
            .to receive(:get)
            .with(package_location)
            .and_return(response)

          expect { call }.to raise_exception(
            Logic::Package::PackageRetrievalError,
            'Failed to retrieve package, received response with http status: 500'
          )
        end
      end

      context 'internal error' do
        let(:internal_error) { RuntimeError.new }

        it 'raises exception' do
          expect(client)
            .to receive(:get)
            .with(package_location)
            .and_raise(internal_error)

          expect { call }.to raise_exception(
            Logic::Package::PackageRetrievalError,
            'Failed to retrieve package'
          ) do |e|
            expect(e.original_exeption).to eq internal_error
          end
        end
      end
    end
  end
end
