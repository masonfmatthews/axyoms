class AssignmentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :edit_scores, :update_scores]
  before_action :set_graph_cache, only: [:new, :create, :edit, :update]
  before_action :set_badge_scores, only: [:edit, :update]

  def edit_scores
    @concepts = Concept.already_scored
    @students = Student.all
    @score_hash = {}
    @students.each do |student|
      score = Score.where(assignment_id: @assignment.id,
          student_id: student.id).first
      @score_hash[student.id] = {score: score && score.score,
          comments: score && score.comments}
    end
  end

  def update_scores
    params[:students].each do |student_id, score_hash|
      score = Score.find_or_create_by(assignment_id: @assignment.id,
          student_id: student_id)
      score.score = score_hash[:score].to_i
      score.comments = score_hash[:comments]
      score.save!
      unless score_hash[:positives].blank?
        Impression.find_or_create_by(assignment_id: @assignment.id,
            student_id: student_id,
            concept_uuid: score_hash[:positives],
            positive: true)
      end
    end
    redirect_to assignments_url, notice: 'Scores were successfully saved.'
  end

  def index
    @assignments = Assignment.paginate(page: params[:page])
  end

  def new
    @assignment = Assignment.new
  end

  def edit
  end

  def show
    redirect_to edit_assignment_path(@assignment)
  end

  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      #TODO: I dislike that this happens AFTER saving the assignment.  It's because
      #  .build doesn't work on an association if the parent object hasn't been
      #  saved yet.  It also means that the checkboxes have to be rechecked
      #  if other form validations fail.
      #  This is a prime candidate for my first crack at a FORM OBJECT.
      @assignment.set_coverage(params[:coverage])
      @assignment.save

      redirect_to assignments_url, notice: 'Assignment was successfully created.'
    else
      render :new
    end
  end

  def update
    @assignment.set_coverage(params[:coverage])
    if @assignment.update(assignment_params)
      redirect_to assignments_url, notice: 'Assignment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @assignment.destroy
      redirect_to assignments_url, notice: 'Assignment was successfully destroyed.'
    else
      flash[:error] = "Assignment could not be deleted."
      redirect_to edit_assignment_url(@assignment)
    end
  end

  private
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def set_graph_cache
      @graph_cache = GraphCache.get
    end

    def set_badge_scores
      @student_scores = {}
      Student.all.each do |s|
        @student_scores[s.name] = @assignment.average_score(s)
      end
    end

    def assignment_params
      params.require(:assignment).permit(:name, :uri)
    end
end
