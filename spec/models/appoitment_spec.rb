require 'rails_helper'

RSpec.describe Appoitment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
   # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:user) }
  it { should belong_to(:doctor) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:date) }
end
