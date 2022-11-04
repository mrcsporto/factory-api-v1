class Order < ApplicationRecord
  include AASM
  validates :aasm_state, :product_id, :inventory_center_id, presence: true
	belongs_to :inventory_center
	belongs_to :product

	paginates_per 10
  
	accepts_nested_attributes_for :product, allow_destroy: true
	accepts_nested_attributes_for :inventory_center, allow_destroy: true

  aasm do
    state :compromised, initial: true
    state :canceled, :consumed

    event :consume do
      after do
        product.update(quantity: product.quantity - 1)
      end
      transitions from: :compromised, to: :consumed
    end

    event :cancel do
      after do
        product.update(quantity: product.quantity + 1)
      end
      transitions from: :consumed, to: :canceled
    end
  end
  
end