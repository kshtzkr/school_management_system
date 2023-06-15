require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "associations" do
    it { should belong_to(:school) }
    it { should have_many(:batches) }
  end
end
