require 'rails_helper'

RSpec.describe Batch, type: :model do
  describe "associations" do
    it { should belong_to(:course) }
    it { should have_many(:user_batches) }
    it { should have_many(:users).through(:user_batches) }
  end
end
