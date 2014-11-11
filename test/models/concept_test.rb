class ConceptTest < Minitest::Test
  def test_import_with_nothing
    Concept.destroy_all
    Concept.import_nodes("")
    assert_equal Concept.count, 0
  end

  def test_import_with_one
    Concept.destroy_all
    Concept.import_nodes('Test // Is Awesome')
    assert_equal Concept.where(name: "Test").first.description, "Is Awesome"
  end

  def test_import_with_name_only
    Concept.destroy_all
    Concept.import_nodes('Test')
    assert_equal Concept.where(name: "Test").first.description, nil
  end

  def test_import_with_many_roots
    Concept.destroy_all
    Concept.import_nodes(%q{
Test1 // Is Root
Test2 // Is Root
})
    assert_equal Concept.count, 2
    t2 = Concept.where(name: "Test2").first
    assert_equal t2.description, "Is Root"
    assert t2.child_concepts.blank?
  end

  def test_import_with_children
    Concept.destroy_all
    Concept.import_nodes(%q{
Test1 // Is Root
 Test2 // Is Child
  Test3 // Is Grandchild
})
    assert_equal Concept.count, 3
    t2 = Concept.where(name: "Test2").first
    assert_equal t2.description, "Is Child"
    assert_equal t2.child_concepts.length, 1
    assert_equal t2.child_concepts[0].description, "Is Grandchild"
    assert_equal t2.parent_concept.blank?, false
    assert_equal t2.parent_concept.description, "Is Root"
  end

  def test_import_with_duplicate_names
    Concept.destroy_all
    assert_raises(Neo4j::ActiveNode::Persistence::RecordInvalidError) {
      Concept.import_nodes(%q{
Test1 // Is Root
Test1 // Is a Duplicate Name
})
    }
    assert_equal Concept.count, 0
  end

  def test_import_with_too_much_indentation
    Concept.destroy_all
    assert_raises(RuntimeError) {
      Concept.import_nodes(%q{
Test1 // Is Root
   Test2 // Is Too Indented
})
    }
    assert_equal Concept.count, 0
  end
end
