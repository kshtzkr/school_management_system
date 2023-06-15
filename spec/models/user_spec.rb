require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:user_roles) }
    it { should have_many(:roles).through(:user_roles) }
    it { should have_many(:user_batches) }
    it { should have_many(:batches).through(:user_batches) }
  end

  describe "Devise modules" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password).on(:create) }
    it { is_expected.to validate_confirmation_of(:password).on(:create) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe "methods" do
    before(:all) do
      @student_role = FactoryBot.create(:role, name: 'student')
      @admin_role = FactoryBot.create(:role, name: 'admin')
      @school_admin_role = FactoryBot.create(:role, name: 'school_admin')
    end

    it "#is_student? returns true when the user has the 'student' role" do
      user = FactoryBot.create(:user)
      UserRole.create(user: user, role: @student_role)
      expect(user.is_student?).to be true
    end

    it "#is_student? returns false when the user does not have the 'student' role" do
      user = FactoryBot.create(:user)
      UserRole.create(user: user, role: @admin_role)
      expect(user.is_student?).to be false
    end

    it "#is_admin? returns true when the user has the 'admin' role" do
      user = FactoryBot.create(:user)
      UserRole.create(user: user, role: @admin_role)
      expect(user.is_admin?).to be true
    end

    it "#is_admin? returns false when the user does not have the 'admin' role" do
      user = FactoryBot.create(:user)
      UserRole.create(user: user, role: @student_role)
      expect(user.is_admin?).to be false
    end

    it "#is_school_admin? returns true when the user has the 'school_admin' role" do
      user = FactoryBot.create(:user)
      UserRole.create(user: user, role: @school_admin_role)
      expect(user.is_school_admin?).to be true
    end

    it "#is_school_admin? returns false when the user does not have the 'school_admin' role" do
      user = FactoryBot.create(:user)
      UserRole.create(user: user, role: @admin_role)
      expect(user.is_school_admin?).to be false
    end
  end
end
