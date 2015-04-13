class AssignmentsController < ApplicationController
  before_action :logged_in_user
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :set_graph_cache, only: [:new, :create, :edit, :update]

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

    def assignment_params
      params.require(:assignment).permit(:name, :uri)
    end
end
