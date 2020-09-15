require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # ensure User model has a 1:m relationship with the model
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:appointments).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }  
  it { should validate_presence_of(:image) } 
  # Validation tests
  # ensure columns title and created_by are present before saving
 
end
