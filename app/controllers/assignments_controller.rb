class AssignmentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :edit_scores, :update_scores]
  before_action :set_graph_cache, only: [:new, :create, :edit, :update]
  before_action :set_badge_scores, only: [:edit, :update]

  def edit_scores
    @score_hash = {}
    Student.all.each do |s|
      @score_hash[s] = {}
      @assignment.concepts.each do |c|
        @score_hash[s][c] = Score.where(student: s,
            concept_uuid: c.uuid, assignment: @assignment).first
      end
    end
  end

  def update_scores
    params[:scores].each do |student_id, concepts_hash|
      concepts_hash.each do |concept_uuid, score_value|
        if score_value.to_i > 0
          score = Score.find_or_create_by(student_id: student_id,
              concept_uuid: concept_uuid, assignment: @assignment)
          score.score = score_value.to_i
          score.save!
        else
          Score.where(student_id: student_id,
              concept_uuid: concept_uuid, assignment: @assignment).destroy_all
        end
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
      @concept_scores = {}
      @assignment.concepts.each do |c|
        @concept_scores[c.name] = c.average_score(assignment_id: @assignment.id)
      end
      @concept_scores = @concept_scores.sort_by{|k,v| -(v.to_f)}

      @student_scores = {}
      Student.all.each do |s|
        @student_scores[s.name] = s.average_score(assignment_id: @assignment.id)
      end
    end

    def assignment_params
      params.require(:assignment).permit(:name, :uri)
    end
end
