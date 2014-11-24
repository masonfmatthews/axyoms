class UnitsController < ApplicationController
  before_action :logged_in_user
  before_action :set_unit, only: [:edit, :update, :destroy]
  before_action :set_graph_cache, only: [:new, :create, :edit, :update]

  def index
    @units = Unit.paginate(page: params[:page])
  end

  def new
    @unit = Unit.new
  end

  def edit
    params[:coverage] = @unit.coverage_hash
  end

  def create
    @unit = Unit.new(unit_params)
    if params[:coverage]
      @unit.new_coverage(params[:coverage].keys)
    end

    if @unit.save
      redirect_to units_url, notice: 'Unit was successfully created.'
    else
      render :new
    end
  end

  def update
    if @unit.update(unit_params)
      @unit.replace_coverage((params[:coverage] || Hash.new).keys)
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
      @graph_cache = GraphCache.get_cache(nil)
    end

    def unit_params
      params.require(:unit).permit(:name, :delivered_at)
    end
end
