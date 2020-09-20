require 'rails_helper'

RSpec.describe CategoryDoctor, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:doctor) }
end
