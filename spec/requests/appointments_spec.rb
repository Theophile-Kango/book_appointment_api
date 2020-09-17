# spec/requests/todos_spec.rb
require 'rails_helper'
require 'date'

RSpec.describe 'appointments API', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:image) { Rack::Test::UploadedFile.new('./spec/support/corona.png', 'image/png') }
  # add todos owner
  let(:headers) { valid_headers.except('Authorization') }
  let(:date_now) { DateTime.now() }

  let(:user_credentials) do
    {
      email: user.email,
      password: user.password
    }.to_json
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
    before { post '/auth/login', params: user_credentials, headers: headers }

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
    let(:valid_attributes) do
      # send json payload
      { date: date_now }.to_json 
    end
    # valid payload
    
    #let(:valid_attributes) { { date: '14-09-2020 1:03', category_id: nil, doctor_id: nil, user_id: nil } }

    it 'Create an appointment with valid parameters' do
      token = json['auth_token']
      post '/appointments', headers: appointment_headers(token), params: valid_attributes(user.id)
      id = json['id']
      post '/appointments', headers: appointment_headers(token), params: { appointment_id: id }.to_json
      expect(json['date']).to eq(date_now)

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  

    context 'when the request is invalid' do
      let(:invalid_attributes) { { date: nil }.to_json }
      before { post '/appointments', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /appointments/:id
  describe 'PUT /appointments/:id' do
    let(:valid_attributes) { DateTime.now().to_json }

    context 'when the record exists' do
      before { put "/appointments/#{json['id']}", params: valid_attributes, headers: headers }

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
    before { delete "/appointments/#{json['id']}", params: {}, headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
  end

end
