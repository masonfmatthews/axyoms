class MapperController < ApplicationController
  def show
    @graph = Graph.new
  end
end
