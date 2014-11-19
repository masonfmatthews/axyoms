class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.integer :order_number
      t.boolean :completed

      t.timestamps
    end
  end
end
