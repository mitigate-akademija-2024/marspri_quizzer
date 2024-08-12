class Quiz < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validate :at_least_two_questions

  before_validation :normalize_title

  before_save :normalize_description

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  def unanswered_questions?(answers)
    answers.values.any?(&:blank?)
  end

  def has_questions?
    questions.exists?
  end

  protected

  def normalize_title
    Rails.logger.info("Quiz#normalize_title called")
    self.title = title.to_s.squish.capitalize
  end

  def normalize_description
    Rails.logger.info("Quiz#normalize_description called")
    self.description = description.to_s.squish
  end

  private

  def at_least_two_questions
    if questions.size < 2
      errors.add(:base, "A quiz must have at least two questions")
    end
  end
end
