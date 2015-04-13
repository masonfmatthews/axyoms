class ReferencesController < ApplicationController
  before_action :logged_in_user
  before_action :set_reference, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def show
    redirect_to edit_reference_path(@reference)
  end

  def new
    @reference = Reference.new(concept_uuid: params[:concept_uuid])
  end

  def edit
  end

  def create
    @reference = Reference.new(reference_params)

    if @reference.save
      redirect_to references_url, notice: 'Reference was successfully created.'
    else
      render :new
    end
  end

  def update
    if @reference.update(reference_params)
      redirect_to references_url, notice: 'Reference was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reference.destroy
    redirect_to references_url, notice: 'Reference was successfully destroyed.'
  end

  private
    def set_reference
      @reference = Reference.find(params[:id])
    end

    def reference_params
      params.require(:reference).permit(:description, :uri, :concept_uuid)
    end
end
