class Question < ApplicationRecord
  validates :question_text, presence: true

  belongs_to :quiz
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: :true, reject_if: proc { |attributes| attributes['answer_text'].blank? }

  validate :at_least_two_answers
  validate :has_correct_answer

  private

  def at_least_two_answers
    if answers.reject(&:marked_for_destruction?).size < 2
      errors.add(:base, "A question must have at least two answers")
    end
  end

  def has_correct_answer
    unless answers.any? { |answer| answer.correct? && !answer.marked_for_destruction? }
      errors.add(:base, "A question must have at least one correct answer")
    end
  end
end
