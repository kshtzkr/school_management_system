require 'rails_helper'

RSpec.describe UserBatch, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:batch) }
  end
end
