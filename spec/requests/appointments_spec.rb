# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'appointments API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let(:doctor) { create(:doctor) }
  let(:category) { create(:category) }
  let!(:appointments) { create_list(:item, 20, appointment_id: appointment.id) }
  let(:appointment_id) { appointment.id }
  let(:appointment_id) { appointments.first.id }
  # add todos owner
  let(:headers) { valid_headers }

  # Test suite for GET /appointments
  describe 'GET /appointments' do
    # update request with headers
    # make HTTP get request before each example
    before { get '/appointments', params: {}, headers: headers }

    it 'returns appointments' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(20)
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /appointments/:id' do
    before { get "/appointments/#{appointment_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the appointment' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(appointment_id)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:appointment_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

    # Test suite for POST /todos
  describe 'POST /appointments' do
    let(:valid_attributes) do
      # send json payload
      { date: '14-09-2020 1:03', category_id: 1, doctor_id: 1, user_id: user.id.to_s }.to_json 
    end
    # valid payload
    
    #let(:valid_attributes) { { date: '14-09-2020 1:03', category_id: nil, doctor_id: nil, user_id: nil } }

    context 'when the request is valid' do
      before { post '/appointments', params: valid_attributes }

      it 'creates an appointment' do
        expect(json['date']).to eq('14-09-2020 1:03')
      end
  
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
    let(:valid_attributes) { { date: '14-09-2020 1:03' }.to_json }

    context 'when the record exists' do
      before { put "/appointments/#{appointment_id}", params: valid_attributes, headers: headers }

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
    before { delete "/appointments/#{appointment_id}", params: {}, headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
  end

end
