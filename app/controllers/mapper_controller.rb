class MapperController < ApplicationController
  def show
    @graph = Graph.new(Concept.all)
  end
end
