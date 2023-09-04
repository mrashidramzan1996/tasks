# app/controllers/items_controller.rb
class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :update, :destroy]
  
    # GET /items
    def index
      @items = Item.all
  
      # Generate and send CSV file
      csv_data = CSV.generate do |csv|
        csv << ['id', 'name', 'price']
        @items.each do |item|
          csv << [item.id, item.name, item.price]
        end
      end
  
      send_data csv_data, filename: "items.csv"
    end
  
    # GET /items/1
    def show
      render json: @item
    end
  
    # POST /items
    def create
      @item = Item.new(item_params)
  
      if @item.save
        render json: @item, status: :created, location: @item
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /items/1
    def update
      if @item.update(item_params)
        render json: @item
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /items/1
    def destroy
      @item.destroy
    end
  
    private
  
    def set_item
      @item = Item.find(params[:id])
    end
  
    def item_params
      params.require(:item).permit(:name, :price)
    end
  end
  