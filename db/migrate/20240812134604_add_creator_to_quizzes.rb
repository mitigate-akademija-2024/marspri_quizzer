class AddCreatorToQuizzes < ActiveRecord::Migration[7.1]
  def change
    add_reference :quizzes, :creator, null: false, foreign_key: { to_table: :users }
  end
end
class AddCreatorToQuizzes < ActiveRecord::Migration[7.1]
  def change
    add_reference :quizzes, :creator, foreign_key: { to_table: :users }
  end
end
