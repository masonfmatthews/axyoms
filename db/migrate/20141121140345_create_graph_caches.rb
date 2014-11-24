class CreateGraphCaches < ActiveRecord::Migration
  def change
    create_table :graph_caches do |t|
      t.text :unit_id_cache
      t.text :parentage_depth_cache
      t.text :precedence_depth_cache
      t.text :parentage_structure_cache
      t.text :precedence_link_cache
      t.text :all_link_cache

      t.timestamps
    end
  end
end
