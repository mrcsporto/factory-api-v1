class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :aasm_state
      t.references :product, foreign_key: true
      t.references :inventory_center, foreign_key: true

      t.timestamps
    end
  end
end
