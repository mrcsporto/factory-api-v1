module V1
  class ProductSerializer < ActiveModel::Serializer
    attributes :id, :product_sku, :quantity

    belongs_to :inventory_center do
      link(:related) {api_v1_inventory_center_products_url(object.inventory_center.id)}
    end

    has_many :orders do 
      link(:related) {api_v1_product_orders_url(object.id)}
    end

  end
end
