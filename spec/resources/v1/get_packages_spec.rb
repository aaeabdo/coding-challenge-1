require 'spec_helper'

RSpec.describe V1, type: :request do
  include Matchers

  # Because of brevity we will test against the database directly
  # Ideally, that should be just testing that the respective logic class with called and resulted
  # expected output
  describe 'get /packages' do
    subject(:call_endpoint) { get '/packages' }
    let!(:package) { create(:package) }

    context 'success' do
      it 'returns valid response' do
        expect(call_endpoint.body).to be_valid_against_schema('packages')
        expect(call_endpoint.status).to eq 200
      end
    end
  end
end
