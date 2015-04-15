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
      if score = c.average_score(filter_params)
        @color_hash[c.uuid] = score
      end
    end
  end

  private

    def filter_params
      params.require(:filters).permit! if params[:filters]
    end
end
