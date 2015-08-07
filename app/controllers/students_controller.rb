class StudentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_badge_scores, only: [:edit, :update]

  def index
    @students = Student.paginate(page: params[:page])
  end

  def show
    redirect_to edit_student_path(@student)
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to students_url, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  def update
    if @student.update(student_params)
      redirect_to students_url, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def set_badge_scores
      @assignment_scores = {}
      Assignment.all.each do |a|
        @assignment_scores[a.name] = a.average_score(student: @student)
      end
    end

    def student_params
      params.require(:student).permit(:name, :email)
    end
end
