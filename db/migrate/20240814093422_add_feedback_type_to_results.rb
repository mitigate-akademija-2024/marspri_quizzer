class AddFeedbackTypeToResults < ActiveRecord::Migration[7.1]
  def change
    add_column :results, :feedback_type, :string
    add_index :results, :feedback_type
  end
end
