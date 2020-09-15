# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'appointments API', type: :request do
  # initialize test data 
  let!(:appointments) { create_list(:appointment, 10) }
  let(:appointment_id) { appointments.first.id }

  # Test suite for GET /todos
  describe 'GET /appointments' do
    # make HTTP get request before each example
    before { get '/appointments' }

    it 'returns appointments' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /appointments/:id' do
    before { get "/appointments/#{appointment_id}" }

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
    # valid payload
    let(:valid_attributes) { { date: '14-09-2020 1:03', category_id: nil, doctor_id: nil, user_id: nil } }

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
        before { post '/appointments', params: { date: 'Foobar' } }
  
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
  
        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: Created by can't be blank/)
        end
      end
    end

    # Test suite for PUT /appointments/:id
  describe 'PUT /appointments/:id' do
    let(:valid_attributes) { { date: '14-09-2020 1:03' } }

    context 'when the record exists' do
      before { put "/appointments/#{appointment_id}", params: valid_attributes }

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
    before { delete "/appointments/#{appointment_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
