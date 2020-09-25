require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:category_doctors) }
  it { should have_many(:doctors) }
end
