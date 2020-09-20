require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it { should have_many(:category_doctors) }
  it { should have_many(:categories) }
  it { should have_many(:appointments).dependent(:destroy) }
end
