require 'rails_helper'

RSpec.describe School, type: :model do
  describe "associations" do
    it { should have_many(:courses) }
  end
end
