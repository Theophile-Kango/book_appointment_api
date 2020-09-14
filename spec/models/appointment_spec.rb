require 'rails_helper'

RSpec.describe Appointment, type: :model do
   # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:user) }
  it { should belong_to(:doctor) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:date) }
end
