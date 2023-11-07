class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items
  end

  def show
  end

  def new
    @cart_item = CartItem.new
  end

  def edit
  end


  def create

    orders = params[:cart_items].to_unsafe_h.select{|x,y| y > '0'}
    check = false
    orders.each do |product_id, quantity|

      @cart_item = CartItem.find_by({user_id: current_user.id, product_id: product_id})

      if (@cart_item == nil)
        @cart_item = CartItem.new({user_id: current_user.id, product_id: product_id, quantity: quantity})
        check = check or not @cart_item.save
      else
        check = check or not @cart_item.update({quantity: @cart_item.quantity + quantity.to_i})
      end
    end

    respond_to do |format|
      if not check
        format.html { redirect_to cart_items_url, notice: "CartItems was successfully created." }
        format.json { render :show, status: :created, location: @cart_item }
      else
        format.html { redirect_back fallback_location: root_path, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update

  #   # params[:id][:quantity] = (params[:id][:add] ? @cart_item.quantity + 1).to_s

  #   respond_to do |format|
  #     if @cart_item.update(params[:id])
  #       format.html { redirect_to product_url(@cart_item), notice: "CartItem was successfully updated." }
  #       format.json { render :show, status: :ok, location: @cart_item }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @cart_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @cart_item.destroy!

    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: "CartItem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

end
