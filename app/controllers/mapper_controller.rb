class MapperController < ApplicationController
  before_action :logged_in_user
  before_action :set_graph

  def packed_graph
  end

  def force_graph
  end

  private def set_graph
    @graph = Graph.new(Concept.all)
  end
end
