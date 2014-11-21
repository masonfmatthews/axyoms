class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
