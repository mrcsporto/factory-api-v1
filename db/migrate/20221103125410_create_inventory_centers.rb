class CreateInventoryCenters < ActiveRecord::Migration[6.1]
  def change
    create_table :inventory_centers do |t|
      t.string :name

      t.timestamps
    end
  end
end
