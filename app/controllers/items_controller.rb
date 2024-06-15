# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/1
  def show; end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit; end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      Discordrb::API::Channel.create_message(
        "Bot #{ENV['DISCORD_BOT_TOKEN']}",
        ENV['DISCORD_CHANNEL_ID'],
        "#{@item.name}が出品されました！",
        false,
        [{
          title: @item.name,
          description: "#{@item.description}\n価格: #{@item.price}円",
          color: 16_083_556,
          timestamp: @item.created_at,
          url: item_url(@item)
        }]
      )
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy!
    redirect_to items_url, notice: 'Item was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, :price, :description)
  end
end
