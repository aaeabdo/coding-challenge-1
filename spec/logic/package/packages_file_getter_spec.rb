require 'spec_helper'
require_relative '../../../logic/package'

RSpec.describe Logic::Package::PackagesFileGetter do
  subject(:call) { described_class.call(client, server_dir, packages_file_name) }

  let(:client)             { class_double('HTTP::Client') }
  let(:server_dir)         { 'http://www.example.com/' }
  let(:packages_file_name) { 'PACKAGES'}
  let(:location)           { server_dir + packages_file_name }

  context '.call' do
    let(:response) { double('response', body: body, error?: error, code: code) }
    let(:body)     { double('body') }
    let(:code)     { 200 }

    context 'success' do
      let(:error)    { false }

      it 'runs successfully' do
        expect(client)
          .to receive(:get)
          .with(location)
          .and_return(response)

        expect(call).to eq body
      end
    end

    context 'failure' do
      let(:error) { true }
      let(:code)  { 500 }

      context 'http error' do
        it 'raises exception' do
          expect(client)
            .to receive(:get)
            .with(location)
            .and_return(response)

          expect { call }.to raise_exception(
            Logic::Package::PackagesFileRetrievalError,
            'Failed to retrieve packages file, received response with http status: 500'
          )
        end
      end

      context 'internal error' do
        let(:internal_error) { RuntimeError.new }

        it 'raises exception' do
          expect(client)
            .to receive(:get)
            .with(location)
            .and_raise(internal_error)

          expect { call }.to raise_exception(
            Logic::Package::PackagesFileRetrievalError,
            'Failed to retrieve packages file'
          ) do |e|
            expect(e.original_exeption).to eq internal_error
          end
        end
      end
    end
  end
end
