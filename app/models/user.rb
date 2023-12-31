class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :user_batches
  has_many :batches, through: :user_batches
  # scope :students, -> { user_roles.where(manual: true) }

  def is_student?
    roles.pluck(:name).include?('student')
  end

  def is_admin?
    roles.pluck(:name).include?('admin')
  end

  def is_school_admin?
    roles.pluck(:name).include?('school_admin')
  end
end
