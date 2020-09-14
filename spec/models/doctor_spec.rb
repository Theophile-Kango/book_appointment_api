require 'rails_helper'

RSpec.describe Doctor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it { should have_many(:category_doctors).dependent(:destroy) }
  it { should have_many(:categories) }
end
