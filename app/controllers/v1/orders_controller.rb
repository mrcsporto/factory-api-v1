module V1
  class OrdersController < ApplicationController
    before_action :set_order,
                  :set_inventory_center, 
                  :set_product

    # GET /api/v1/orders
    def index
      @orders = Order.all.page(params[:page])
      render json: @orders
    end

    # GET /api/v1/orders/:order_id/
    def show
      if params[:id]
        @order = Order.find(params[:id])
        render json: @order
			elsif params[:inventory_center_id]
				render json: @inventory_center.orders
      elsif params[:product_id]
        render json: @product.orders
			end
    end

    # POST /api/v1/orders/?inventory_center_id=5&product_sku=75275105
    def create
      product = Product.find_by(product_sku: params[:product_sku], 
          inventory_center_id: params[:inventory_center_id]
        )
      @order = Order.new(inventory_center_id: params[:inventory_center_id], product: product)
        if @order.save
          render json: @order.to_json(root: true, only: :id),
            status: :created, 
            location: api_v1_order_url(@order)
        else
          render json: @order.errors, status: :unprocessable_entity
        end
    end

    # PATCH /api/v1/orders/:order_id/
    def update
      if @order.compromised?
        @order.consume!
        json_consume_response(@order)
      elsif @order.consumed?
        @order.cancel!
        json_cancel_response(@order)
      elsif @order.canceled?
        render json: { success: false, order_id: @order.id, response: "Order already canceled" }, status: :unprocessable_entity
      else
        render json: @order.errors, status: :unprocessable_entity, message: 'Order Consumed'
      end
    end

    private
      def set_inventory_center
        if params[:inventory_center_id]
          @inventory_center = InventoryCenter.find(params[:inventory_center_id])
        else
          @inventory_center = InventoryCenter.all
        end
      end

      def set_order
        if params[:id]
          if Order.where(id: params[:id]).any?
            @order = Order.find(params[:id])
          else
            @order = params[:id]
            json_notfound_response(@order)
          end
        else
          @order = Order.all
        end
      end

      def set_product
        if params[:product_id]
          @product = Product.find(params[:product_id])
        else
          @product = Product.all
        end
      end

      def json_consume_response(response, message: 'Order Consumed', code: 200, success: true)
        render json: {
          code: code,
          success: success,
          message: message,
          response: @order.as_json(root: true, only: :id)
        }
      end

      def json_cancel_response(response, message: 'Order Canceled', code: 200, success: true)
        render json: {
          code: code,
          success: success,
          message: message,
          response: @order.as_json(root: true, only: :id)
        }
      end

      def json_notfound_response(response, message: 'Order id not found', success: false, status: :unprocessable_entity)
        render json: {
          success: success,
          message: "Order id " + @order.as_json(root: true, only: :id) + " not found!",
        }
      end

      #Deserialization
      def inventory_center_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end

      def order_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end

      def product_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
      
  end
end