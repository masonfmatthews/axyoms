class GraphImporterTest < Minitest::Test
  def setup
    @graph = Graph.new(Concept.all)
    @graph.destroy
    @graph_importer = GraphImporter.new(@graph)
  end

  def test_import_with_nothing
    @graph_importer.import_new_nodes("")
    assert_equal Concept.count, 0
  end

  def test_import_with_one
    @graph_importer.import_new_nodes('Test // Is Awesome')
    assert_equal Concept.where(name: "Test").first.description, "Is Awesome"
  end

  def test_import_with_name_only
    @graph_importer.import_new_nodes('Test')
    assert_equal Concept.where(name: "Test").first.description, nil
  end

  def test_import_with_many_roots
    @graph_importer.import_new_nodes(%q{
Test1 // Is Root
Test2 // Is Root
})
    assert_equal Concept.count, 2
    t2 = Concept.where(name: "Test2").first
    assert_equal t2.description, "Is Root"
    assert t2.child_concepts.blank?
  end

  def test_import_with_children_and_second_root
    @graph_importer.import_new_nodes(%q{
Test1 // Is Root
 Test2 // Is Child
  Test3 // Is Grandchild
Test4 // Is Root
})
    assert_equal Concept.count, 4
    t2 = Concept.where(name: "Test2").first
    assert_equal t2.description, "Is Child"
    assert_equal t2.child_concepts.length, 1
    assert_equal t2.child_concepts[0].description, "Is Grandchild"
    assert_equal t2.parent_concept.blank?, false
    assert_equal t2.parent_concept.description, "Is Root"
    t4 = Concept.where(name: "Test4").first
    assert_equal t4.description, "Is Root"
    assert_equal t4.parent_concept.blank?, true
  end

  def test_import_with_duplicate_names
    assert_raises(Neo4j::ActiveNode::Persistence::RecordInvalidError) {
      @graph_importer.import_new_nodes(%q{
Test1 // Is Root
Test1 // Is a Duplicate Name
})
    }
    assert_equal Concept.count, 0
  end

  def test_import_with_too_much_indentation
    assert_raises(RuntimeError) {
      @graph_importer.import_new_nodes(%q{
Test1 // Is Root
   Test2 // Is Too Indented
})
    }
    assert_equal Concept.count, 0
  end
end
