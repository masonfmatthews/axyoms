class CreateImpressions < ActiveRecord::Migration
  def change
    create_table :impressions do |t|
      t.integer :student_id
      t.uuid :concept_uuid
      t.integer :assignment_id
      t.boolean :positive

      t.timestamps null: false
    end
  end
end
