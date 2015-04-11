class CreateAssignmentCoverages < ActiveRecord::Migration
  def change
    create_table :assignment_coverages do |t|
      t.references :assignment, index: true
      t.uuid :concept_uuid

      t.timestamps
    end
  end
end
