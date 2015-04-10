class ConceptsController < ApplicationController
  def summary
    @concept = Concept.find(params[:uuid])
    render partial: "summary"
  end

  # PATCH
  def update
    @concept = Concept.find(params[:concept][:uuid])
    @concept.name = params[:concept][:name]
    @concept.description = params[:concept][:description]
    @concept.save!
  end
end
