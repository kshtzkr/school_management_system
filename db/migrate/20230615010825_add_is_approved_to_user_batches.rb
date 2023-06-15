class AddIsApprovedToUserBatches < ActiveRecord::Migration[7.0]
  def change
    add_column :user_batches, :is_approved, :boolean, default: false
  end
end
