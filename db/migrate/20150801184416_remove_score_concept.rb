class RemoveScoreConcept < ActiveRecord::Migration
  def change
    remove_column :scores, :concept_uuid, :uuid
    add_column :scores, :comments, :text
  end
end
