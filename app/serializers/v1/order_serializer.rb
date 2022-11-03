module V1
  class OrderSerializer < ActiveModel::Serializer
    attributes :id, :aasm_state

    belongs_to :product do 
      link(:related) {api_v1_product_orders_url(object.product.id)}
    end

    belongs_to :inventory_center do
      link(:related) {api_v1_inventory_center_orders_url(object.inventory_center.id)}
    end

  end
end