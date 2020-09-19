# frozen_string_literal: true

# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'appointments API', type: :request do
  describe 'POST /auth/login' do
    # create test appointment
    let!(:user) { create(:user) }
    let!(:admin) { create(:admin) }
    let(:doctor) { create(:doctor, user: user) }
    let(:category) { create(:category) }
    let!(:image) { Rack::Test::UploadedFile.new('./spec/support/corona.png', 'image/png') }
    let!(:appointments) { create(:appointment, user: user, category: category, doctor: doctor) }

    def appointment_headers(token)
      {
        'Authorization' => token.to_s,
        'Content-Type' => 'application/json'
      }
    end
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end

    let(:admin_credentials) do
      {
        email: admin.email,
        password: admin.password
      }.to_json
    end

    let(:invalid_attributes) do
      attributes_for(:appointment, date: 'invalid', category_id: '', doctor_id: '', user_id: '')
    end

    def valid_attributes(id)
      attributes_for(:appointment,
                     name: 'invalid',
                     email: 'me@gmail.com',
                     user_id: id,
                     doctor_id: doctor.id,
                     image: image)
    end

    context 'Appointments requests' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'Does not create an Appointment with invalid informations' do
        post '/appointments', params: invalid_attributes
        expect(response.status).to eq(422)
      end
    end
  end
end
