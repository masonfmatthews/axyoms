class ConceptsController < ApplicationController
  before_action :logged_in_user, except: [:summary]

  def summary
    @student = Student.find_by_id(session[:highlighted_student_id])
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
    clear_highlighted_student
    @active_uuids = UnitCoverage.completed_uuids
  end

  def color_by_comprehension
    save_highlighted_student
    @color_hash = {}
    Concept.all.each do |c|
      if score = c.average_score(@student)
        @color_hash[c.uuid] = score
      end
    end
  end
end
