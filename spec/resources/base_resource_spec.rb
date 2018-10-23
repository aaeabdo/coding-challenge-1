require 'spec_helper'

RSpec.describe BaseResource, type: :request do
  describe 'get /health_check' do
    subject(:call_endpoint) { get '/health_check' }

    context 'with a database running' do
      let(:response_hash) do
        {
          service_name:  SERVICE_NAME,
          database_name: "#{SERVICE_NAME}_test",
          environment:   'test'
        }
      end

      it 'responds successfully' do
        expect(call_endpoint.body).to   eq response_hash.to_json
        expect(call_endpoint.status).to eq 200
      end
    end

    context 'without a database' do
      let(:response_hash) do
        {
          code:    500,
          message: "Database Not running"
        }
      end

      before do
        allow(ActiveRecord::Base).to receive(:connection).and_raise(StandardError)
      end

      it 'returns a 500 response' do
        expect(call_endpoint.body).to   eq response_hash.to_json
        expect(call_endpoint.status).to eq 500
      end
    end
  end
end
