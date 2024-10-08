class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:index, :new, :create]
  before_action :set_question, only: [:destroy, :edit, :update]

  def index
    @questions = @quiz.questions
  end
  def create
    @question = @quiz.questions.new(question_params)
    if params[:commit] == "add_answer"
      @question.answers.new
      render :new, status: :unprocessable_entity
    else
      if @question.save
        flash.notice = "Question was successfully created."
        redirect_to quiz_url(@quiz)
      else
        if @question.answers.size < 2
          @question.answers.new while @question.answers.size < 2
        end
        render :new, status: :unprocessable_entity
      end
    end
  end

  def new
    @question = @quiz.questions.new
    2.times { @question.answers.new }
  end

  def add_answer
    @question = @quiz.questions.new(question_params)
    @question.answers.new
    render :new
  end

  # DELETE /questions/1
  def destroy
    @question.destroy!

    redirect_to quiz_path(@question.quiz), notice: "Question was successfully destroyed."
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to quiz_url(@question.quiz), notice: "Question updated"
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question_text, answers_attributes: [:id, :answer_text, :correct, :_destroy ])
  end


end
