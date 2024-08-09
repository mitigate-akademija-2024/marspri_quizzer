class Question < ApplicationRecord
  validates :question_text, presence: true

  belongs_to :quiz
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: :true, reject_if: proc { |attributes| attributes['answer_text'].blank? }

  # validate :validate_answers

  # private

  # def validate_answers
  #   errors.add(:answers, :too_few, message: "At least 2 answers needed.") if answers.count 
  #   errors.add(:answers, :no_correct, message: "At least 1 correct answer needed.") if answers.none? {|ans| ans.correct?}
  # end
end