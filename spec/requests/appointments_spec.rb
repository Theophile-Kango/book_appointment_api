# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'appointments API', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:image) { Rack::Test::UploadedFile.new('./spec/support/corona.png', 'image/png') }
  # add todos owner
  let(:headers) { valid_headers.except('Authorization') }
  let(:date_now) { DateTime.current }

  let(:user_credentials) do
    {
      email: user.email,
      password: user.password
    }.to_json
  end

  let(:valid_credentials) do
    {
      email: user.email,
      password: user.password
    }.to_json
  end

  let(:invalid_attributes) do
    attributes_for(:appointment, date: '')
  end

  def appointment_headers(token)
    {
      'Authorization' => token.to_s,
      'Content-Type' => 'application/json'
    }
  end

  def valid_attributes(id)
    attributes_for(:appointment,
                   name: 'invalid',
                   email: 'me@gmail.com',
                   user_id: id,
                   date: date_now,
                   image: image)
  end

  # Test suite for GET /appointments
  describe 'GET /appointments' do
    # update request with headers
    # make HTTP get request before each example
    before { post '/auth/login', params: valid_credentials, headers: headers }

    it 'returns appointments' do
        # Note `json` is a custom helper to parse JSON responses
        token = json['auth_token']
        get '/appointments', headers: appointment_headers(token)
        expect(json).to eq([])
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /todos
  describe 'POST /appointments' do
    context 'when the request is valid' do
      before { post '/appointments', params: valid_attributes(user.id), headers: headers }
      before { post '/appointments', headers: appointment_headers(json['auth_token']), params: valid_attributes(user.id) }

      it 'creates an appointment' do
        expect(json['date']).to eq(date_now)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  
    context 'when the request is invalid' do
      before { post '/appointments', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Type can't be blank/)
      end
    end
  end

  # Test suite for PUT /appointments/:id
  describe 'PUT /appointments/:id' do
    before { post '/auth/login', params: valid_credentials, headers: headers }

    context 'when the record exists' do
      before { put "/appointments/#{json['id']}", params: valid_attributes(user.id), headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /appointments/:id
  describe 'DELETE /appointments/:id' do
    before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
  end

end
