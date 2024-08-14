class AddFeedbackToQuizzes < ActiveRecord::Migration[7.1]
  def change
    add_column :quizzes, :feedback, :text
  end
end
