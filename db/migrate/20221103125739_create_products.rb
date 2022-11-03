class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_sku
      t.integer :quantity
      t.references :inventory_center, foreign_key: true

      t.timestamps
    end
  end
end
