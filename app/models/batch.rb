class Batch < ApplicationRecord
  belongs_to :course
  has_many :user_batches
  has_many :users, through: :user_batches
end
