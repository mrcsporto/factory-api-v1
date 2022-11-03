module V1
  class InventoryCenterSerializer < ActiveModel::Serializer
    attributes :id, :name

    has_many :products do 
      link(:related) {api_v1_inventory_center_products_url(object.id)}
    end

  end
end
