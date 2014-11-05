class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.uuid :concept_uuid
      t.string :uri
      t.string :description

      t.timestamps
    end
  end
end
