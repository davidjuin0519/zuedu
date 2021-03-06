class LineItemsController < ApplicationController
  before_action :set_line_item, only: [ :update ]

  def index
    @line_items = current_cart.line_items
    render json: @line_items
  end

  def create
    product_detail = ProductDetail.find(params[:product_detail_id])
    CartService.add_product_to_cart(nil, product_detail, current_cart)
    render json: { message: '新增成功' }
  rescue ActiveRecord::RecordNotFound
    render json: { message: '找不到該課程' }, status: 422
  end

  def update
    if @line_item.update line_item_params
      render json: { message: '更新成功' }
    else
      render json: { message: @line_item.errors.full_messages.first }, status: 422
    end
  end

  def destroy
    current_cart.line_items.find(params[:id]).destroy
    render json: { message: '移除成功' }
  rescue ActiveRecord::RecordNotFound
    render json: { message: '購物車內找不到該課程' }, status: 422
  end

private
  def set_line_item
    @line_item = LineItem.find_by id: params[:id]
  end

  def line_item_params
    params.require(:line_items).permit(:product_detail_id, :name, :birth, :gender, :ss_number, :school, :grade, :food_preference, :note, :parent_phone_number, :parent_email)
  end
end