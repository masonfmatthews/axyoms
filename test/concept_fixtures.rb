module ConceptFixtures
  extend ActiveSupport::Concern

  module ClassMethods
    def run_concept_fixtures
      @graph = Graph.new(Concept.all)
      @graph.destroy
      @graph_importer = GraphImporter.new(@graph)
      @graph_importer.import_new_nodes(%q{
one // Is Root
 two // Is Child
  three // Is Grandchild
four // Is Root
})
      @graph_importer.import_new_relationships("one -> four")
    end
  end

  def concepts(sym)
    @concepts ||= {}
    @concepts[sym] ||= Concept.where(name: sym.to_s).first
  end

end
