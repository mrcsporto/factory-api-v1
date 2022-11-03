module V1 
  class InventoryCentersController < ApplicationController
    before_action :set_inventory_center, only: [:show, :update, :destroy]

    # GET /api/v1/inventory_centers
    def index
      @inventory_centers = InventoryCenter.all.page(params[:page])
      render json: @inventory_centers
    end

    # GET /api/v1/inventory_centers/:inventory_center_id
    def show
      render json: @inventory_center
    end

    # POST /api/v1/inventory_centers
    def create
      @inventory_center = InventoryCenter.new(inventory_center_params)
      if @inventory_center.save
        render json: @inventory_center, 
          include: [:products], 
          status: :created, 
          location: api_v1_inventory_center_url(@inventory_center)
      else
        render json: @inventory_center.errors, status: :unprocessable_entity
      end
    end

    # PATCH /api/v1/inventory_centers/:inventory_center_id
    def update
      if @inventory_center.update(inventory_center_params)
        render json: @inventory_center
      else
        render json: @inventory_center.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/inventory_centers/:inventory_center_id
    def destroy
      if @inventory_center.destroy
        json_success_response(@inventory_center)
      else
        render json: @inventory_center.errors, status: :unprocessable_entity
      end
    end

    private
      def set_inventory_center
        @inventory_center = InventoryCenter.find(params[:id])
      end

      def json_success_response(response, message: 'Inventory Center successfully deleted', code: 200, success: true)
        render json: {
          code: code,
          success: success,
          message: message,
          response: @inventory_center.as_json(root: true, except: [:created_at, :updated_at])
        }
      end

      #Deserialization
      def inventory_center_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
      
  end
end


