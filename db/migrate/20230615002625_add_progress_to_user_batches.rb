class AddProgressToUserBatches < ActiveRecord::Migration[7.0]
  def change
    add_column :user_batches, :progress, :integer
    # Add a check constraint to enforce the constraint
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE user_batches
          ADD CONSTRAINT check_progress_within_limit
          CHECK (progress <= 100)
        SQL
      end
    end
  end
end
