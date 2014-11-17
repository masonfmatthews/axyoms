class MapperController < ApplicationController
  before_action :logged_in_user
  def show
    @graph = Graph.new(Concept.all)
  end
end
