module Neo4jTransaction
  def neo4j_transaction
    begin
      tx = Neo4j::Transaction.new
      yield
    rescue
      tx.failure
      raise
    ensure
      tx.close
    end
  end
end
