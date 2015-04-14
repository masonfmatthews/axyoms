class ConceptsController < ApplicationController
  before_action :logged_in_user, except: [:summary]

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

  def color_by_time
    @active_uuids = UnitCoverage.completed_uuids
  end

  def color_by_comprehension
    @color_hash = {}
    Concept.all.each do |c|
      @color_hash[c.uuid] = c.average_score if c.scores.length > 0
    end
  end
end
