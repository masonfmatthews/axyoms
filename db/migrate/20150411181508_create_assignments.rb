class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
