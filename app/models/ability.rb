# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.roles.pluck(:name).include?('admin')
      can :manage, :all
    elsif user.roles.pluck(:name).include?('school_admin')
      can :manage, School
      can :manage, Course, school_id: user.school_id
      can :manage, Batch, course: { school_id: user.school_id }
    elsif user.roles.pluck(:name).include?('student')
      can :read, Course
      can :read, Batch
      # Add additional abilities for the student role
    end
  end
end
