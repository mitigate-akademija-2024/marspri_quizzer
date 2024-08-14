class QuizShareController < ApplicationController
  def new
    @quiz = Quiz.find(params[:id])
  end

  def create
    @quiz = Quiz.find(params[:id])
    emails = params[:emails].split(',').map(&:strip)
    
    emails.each do |email|
      QuizMailer.send_quiz_link(email, @quiz).deliver_later
    end
    
    redirect_to available_quizzes_path, notice: 'Quiz link sent successfully!'
  end

  def send_link
    @quiz = Quiz.find(params[:id])
    render :new
  end
end
