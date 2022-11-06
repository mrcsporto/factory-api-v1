module V1  
	class ProductsController < ApplicationController
		before_action :set_inventory_center, :set_order

		# GET /api/v1/products
		# GET /api/v1/products?product_sku=83028502
		def index
			if params[:product_sku]
				@products = Product.where(product_sku: params[:product_sku])
				render json: @products
			else
				@products = Product.all.page(params[:page])
				render json: @products
			end
		end

    # GET /api/v1/products/:id
  	def show
			if params[:id]
				@product = Product.find(params[:id])
				render json: @product
			else
				render json: @inventory_center.products
			end
		end

		# POST /api/v1/products/?product_sku=75275105&inventory_center_id=2&quantity=2
    def create
      if product_params
        @inventory_center.products << Product.new(
            inventory_center_id: params[:inventory_center_id], 
            product_sku: params[:product_sku],
            quantity: params[:quantity]
          ) 

          if @inventory_center.save
            render json: @inventory_center.products.last, 
              status: :created, 
              location: api_v1_inventory_center_products_url(@inventory_center)
          else
            render json: @inventory_center.errors, status: :unprocessable_entity
          end
      end
    end

		private
		 def set_inventory_center
        if params[:inventory_center_id]
          if InventoryCenter.where(id: params[:inventory_center_id]).any?
            @inventory_center = InventoryCenter.find(params[:inventory_center_id])
          else
            @inventory_center = params[:inventory_center_id]
            render json: { success: false, inventory_center_id: @inventory_center, response: "Inventory Center does NOT exists." }, status: :unprocessable_entity
          end
        else
          @inventory_center = InventoryCenter.all
        end
      end

		def set_order
			if params[:order_id]
				@order = Order.find(params[:order_id])
			else
				@order = Order.all
			end
		end

		def json_notfound_response(response, message: 'Inventory center id not found', success: false, status: :unprocessable_entity)
			render json: {
				success: success,
				message: "Order id " + @order.as_json(root: true, only: :id) + " not found!",
			}
		end

		#Deserialization
		def product_params
			ActiveModelSerializers::Deserialization.jsonapi_parse(params)
		end

    def order_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
    
	end
end

