class GraphController < ApplicationController
  before_action :set_graph
  before_action :set_students
  before_action :clear_highlighted_student

  def packed_graph
  end

  def force_graph
  end

  private def set_graph
    @graph = Graph.new(Concept.all)
  end

  private def set_students
    @students = Student.all
  end
end
