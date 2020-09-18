require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authentication test suite
  describe 'POST /auth/login' do
    # create test user
    let!(:user) { create(:user) }
    let!(:admin) { create(:admin) }
    let!(:image) { Rack::Test::UploadedFile.new('./spec/support/corona.png', 'image/png') }

    def item_headers(token)
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
      attributes_for(:doctor, name: 'invalid', category_id: '')
    end

    def valid_attributes(id)
      attributes_for(:doctor,
                     name: 'invalid',
                     email: 'me@gmail.com',
                     user_id: id,
                     image: image)
    end

    context 'Doctors requests' do
      before { post '/auth/login', params: valid_credentials, headers: headers }
      it 'returns an empty array if there is no created doctors' do
        get '/doctors', headers: item_headers(json['auth_token'])
        expect(json).to eq([])
      end

      it 'Does not create a doctor with invalid informations' do
        post '/doctors', params: invalid_attributes
        expect(response.status).to eq(422)
      end

      it 'Does not create a doctor if the user is not an admin' do
        post '/doctors', headers: item_headers(json['auth_token']), params: valid_attributes(user.id)
        expect(json['message']).to match(/Sorry you must be an admin to perform the requested action/)
      end

      it 'create a doctor if the user is an admin' do
        post '/auth/login', params: admin_credentials, headers: headers
        post '/doctors', headers: item_headers(json['auth_token']), params: valid_attributes(admin.id)
        expect(json['id']).not_to be(nil)
      end
    end
  end
end