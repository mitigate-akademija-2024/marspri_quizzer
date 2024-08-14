class Result < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :user_answers, presence: true
  validates :feedback_type, inclusion: { in: ['positive', 'negative', 'neutral'] }, allow_nil: true
end
