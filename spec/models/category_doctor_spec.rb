require 'rails_helper'

RSpec.describe CategoryDoctor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:category) }
  it { should belong_to(:doctor) }
end
