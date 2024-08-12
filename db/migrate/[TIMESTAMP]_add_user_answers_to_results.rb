class AddUserAnswersToResults < ActiveRecord::Migration[7.0]
  def change
    add_column :results, :user_answers, :text
  end
end
