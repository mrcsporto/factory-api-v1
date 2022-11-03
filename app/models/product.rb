class Product < ApplicationRecord
  validates :product_sku, uniqueness: { scope: :inventory_center_id,
    message: "It's NOT possible to have duplicated SKU in the same inventory center." }

  belongs_to :inventory_center, optional: true
  has_many :orders

  paginates_per 10

  accepts_nested_attributes_for :orders, allow_destroy: true
end
