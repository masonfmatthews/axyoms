class UnitsController < ApplicationController
  before_action :logged_in_user
  before_action :set_unit, only: [:show, :edit, :update, :destroy]
  before_action :set_graph_cache, only: [:new, :create, :edit, :update]

  def index
    @units = Unit.paginate(page: params[:page])
  end

  def new
    @unit = Unit.new
  end

  def edit
  end

  def show
    redirect_to edit_unit_path(@unit)
  end

  def create
    @unit = Unit.new(unit_params)

    if @unit.save
      #TODO: I dislike that this happens AFTER saving the unit.  It's because
      #  .build doesn't work on an association if the parent object hasn't been
      #  saved yet.  It also means that the checkboxes have to be rechecked
      #  if other form validations fail.
      #  This is a prime candidate for my first crack at a FORM OBJECT.
      @unit.set_coverage(params[:coverage])
      @unit.save

      redirect_to units_url, notice: 'Unit was successfully created.'
    else
      render :new
    end
  end

  def update
    @unit.set_coverage(params[:coverage])
    if @unit.update(unit_params)
      redirect_to units_url, notice: 'Unit was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @unit.destroy
    redirect_to units_url, notice: 'Unit was successfully destroyed.'
  end

  private
    def set_unit
      @unit = Unit.find(params[:id])
    end

    def set_graph_cache
      @graph_cache = GraphCache.last
    end

    def unit_params
      params.require(:unit).permit(:name, :delivered_at)
    end
end
