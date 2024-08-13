class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy take submit results top_scores ]
  before_action :authorize_quiz, only: %i[ edit update destroy ]
  before_action :require_login, only: [:show]

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.where(creator: current_user)
  end

  def available
    @quizzes = Quiz.where.not(creator: current_user)
    @quizzes = Quiz.all

    @title = 'These are the quizzes'
    @description = 'lorem ipsum'
  end

  def start
    @title = 'Start some quiz'
    @description = 'lorem ipsum'

    respond_to do |format|
      format.html
      format.json do
        render json: { title: @title, description: "Šī ir json atbilde" }
      end
    end
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
    question = @quiz.questions.build
    2.times { question.answers.build }
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = current_user.created_quizzes.new(quiz_params)

    respond_to do |format|
      if @quiz.save && @quiz.questions.size >= 2
        format.html do
          flash.notice = "Quiz was successfully created this time."
          redirect_to quiz_url(@quiz)
        end
        format.json { render :show, status: :created, location: @quiz }
      else
        @quiz.errors.add(:base, "A quiz must have at least two questions") if @quiz.questions.size < 2
        flash.now.alert = 'Something went wrong'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quiz_url(@quiz), notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz.destroy!

    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: "Quiz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def take
    unless current_user
      redirect_to login_path(redirect_to: take_quiz_path(@quiz)), alert: "Please log in to take the quiz."
      return
    end

    if @quiz.has_questions?
      @questions = @quiz.questions.includes(:answers)
    else
      redirect_to quizzes_path, alert: "This quiz doesn't have any questions yet."
    end
  end

  def submit
    @questions = @quiz.questions.includes(:answers)
    
    if params[:answers].nil?
      flash[:alert] = "Please answer at least one question before submitting."
      redirect_to take_quiz_path(@quiz) and return
    end

    @unanswered = params[:answers].values.count(&:blank?)

    if @unanswered > 0
      flash[:alert] = "Please answer all questions before submitting."
      redirect_to take_quiz_path(@quiz) and return
    end

    @user_answers = params.require(:answers).permit!.to_h
    @score = calculate_score(@questions, @user_answers)
    
    unless current_user
      flash[:alert] = "Please log in before submitting your answers."
      redirect_to login_path(redirect_to: take_quiz_path(@quiz)) and return
    end

    Result.create(quiz: @quiz, user: current_user, score: @score, user_answers: @user_answers)

    redirect_to results_quiz_path(@quiz, score: @score, user_answers: @user_answers)
  end

  def calculate_score(questions, user_answers)
    correct_answers = 0
    questions.each do |question|
      if user_answers[question.id.to_s] == question.answers.find_by(correct: true).id.to_s
        correct_answers += 1
      end
    end
    (correct_answers.to_f / questions.count * 100).round(2)
  end

  def results
    @questions = @quiz.questions.includes(:answers)
    @score = params[:score]
    @user_answers = if params[:user_answers].is_a?(String)
      begin
        JSON.parse(params[:user_answers])
      rescue JSON::ParserError
        eval(params[:user_answers])
      end
    else
      params[:user_answers].to_unsafe_h
    end
  end

  def share_results
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions.includes(:answers)
    @score = params[:score]
    @user_answers = JSON.parse(params[:user_answers]) if params[:user_answers].present?
    @shareable_url = shared_results_quiz_url(@quiz, score: @score, user_answers: @user_answers)
    render :share_results
  end

  def shared_results
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions.includes(:answers)
    @score = params[:score]
    @user_answers = params[:user_answers].to_unsafe_h if params[:user_answers].present?
    render :shared_results
  end

  def top_scores
    @top_scores = @quiz.top_scores
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quiz_params
      params.require(:quiz).permit(:title, :description, questions_attributes: [:question_text, answers_attributes: [:answer_text, :correct]])
    end

    def authorize_quiz
      unless @quiz.creator == current_user
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to quizzes_path
      end
    end
end
