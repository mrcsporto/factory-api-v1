class InventoryCenter < ApplicationRecord
  validates :name, length: { minimum: 2 }, format: { 
    with: /[a-zA-Z]/, message: "Must contain only letters.", presence: true 
  }
  has_many :products, dependent: :destroy
  has_many :orders

  paginates_per 10

  accepts_nested_attributes_for :products, allow_destroy: true
  accepts_nested_attributes_for :orders, allow_destroy: true
end
