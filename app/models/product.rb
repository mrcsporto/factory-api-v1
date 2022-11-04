class Product < ApplicationRecord
  validates :product_sku, :quantity, :inventory_center_id, presence: true
  validates :product_sku, uniqueness: { scope: :inventory_center,
    message: "It's NOT possible to have duplicated SKU in the same inventory center." }
  validates :quantity, numericality: {greater_than: 0 }
  validates_length_of :product_sku, minimum: 3, maximum: 8, allow_blank: false

  belongs_to :inventory_center, optional: true
  has_many :orders

  paginates_per 10

  accepts_nested_attributes_for :orders, allow_destroy: true
end
