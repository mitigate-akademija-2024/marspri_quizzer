class QuizMailer < ApplicationMailer
  def send_quiz_link_email(email, quiz)
    @quiz = quiz
    @quiz_link = take_quiz_url(@quiz)
    mail(to: email, subject: "You've been invited to take a quiz!")
  end

  private

  def take_quiz_url(quiz)
    Rails.application.routes.url_helpers.take_quiz_url(quiz, host: '127.0.0.1', port: "3000")
  end
end
