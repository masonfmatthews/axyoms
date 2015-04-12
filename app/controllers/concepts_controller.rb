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
    @active_uuids = []
    GraphCache.last.unit_id_cache.each do |k, v|
      @active_uuids << k if v.length > 0
    end
  end

  def color_by_comprehension
    @color_hash = {}
    Concept.all.each do |c|
      @color_hash[c.uuid] = c.average_score_for_student(Student.first) if c.scores.length > 0
    end
  end
end
