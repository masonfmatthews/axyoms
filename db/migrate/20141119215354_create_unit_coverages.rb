class CreateUnitCoverages < ActiveRecord::Migration
  def change
    create_table :unit_coverages do |t|
      t.references :unit, index: true
      t.uuid :concept_uuid

      t.timestamps
    end
  end
end
