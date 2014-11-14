class ConceptsController < ApplicationController

  def summary
    @concept = Concept.find(params[:uuid])
    render partial: "summary"
  end
end
