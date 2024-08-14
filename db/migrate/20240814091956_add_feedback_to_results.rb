class AddFeedbackToResults < ActiveRecord::Migration[7.1]
  def change
    add_column :results, :feedback, :text
  end
end
