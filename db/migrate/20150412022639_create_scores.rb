class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :student, index: true
      t.references :assignment, index: true
      t.uuid :concept_uuid
      t.integer :score

      t.timestamps
    end
  end
end
