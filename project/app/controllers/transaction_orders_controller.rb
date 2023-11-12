class TransactionOrdersController < ApplicationController
  before_action :set_transaction_order, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /transaction_orders or /transaction_orders.json
  def index
    @transaction_orders = current_user.role == "admin" ? TransactionOrder.all : current_user.transaction_orders
  end

  # GET /transaction_orders/1 or /transaction_orders/1.json
  def show
  end

  # GET /transaction_orders/new
  def new
    @transaction_order = TransactionOrder.new
  end

  # GET /transaction_orders/1/edit
  def edit
  end

  # POST /transaction_orders or /transaction_orders.json
  def create
    @transaction_order = TransactionOrder.new(transaction_order_params)
    items = params[:cart_items].to_unsafe_h.select{|x,y| y > '0'}
    check = items.empty? or not @transaction_order.save

    items.each do |product_id, number|
      if check
        break
      end
      transaction_item = @transaction_order.transaction_items.build(product_id: product_id, number: number)
      check = check or not transaction_item.save
    end

    respond_to do |format|
      unless check
        current_user.cart_items.destroy_all
        format.html { redirect_to transaction_order_url(@transaction_order), notice: "Transaction order was successfully created." }
        format.json { render :show, order_status: :created, location: @transaction_order }
      else
        format.html { redirect_back fallback_location: root_path, order_status: :unprocessable_entity }
        format.json { render json: @transaction_order.errors, order_status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_orders/1 or /transaction_orders/1.json
  def update
    if current_user.role == "admin" then
      if @transaction_order.order_status == "Unshipped"
        update_status = {order_status: :Shipped}
      else
        format.html { redirect_to transaction_orders_url, order_status: :unprocessable_entity }
      end
    else
      if @transaction_order.order_status == "Unpaid"
        update_status = {order_status: :Unshipped}
      elsif @transaction_order.order_status == "Shipped"
        update_status = {order_status: :Received}
        @transaction_order.transaction_items.each do |item|
          item.product.update({sales_volume: item.product.sales_volume + item.number})
        end
      else
        format.html { redirect_to transaction_orders_url, order_status: :unprocessable_entity }
      end
    end

    respond_to do |format|
      @transaction_order.update(update_status)
      format.html { redirect_to transaction_orders_url, notice: "Transaction order was successfully updated." }
      format.json { render :show, status: :ok, location: @transaction_order }
    end
  end

  # DELETE /transaction_orders/1 or /transaction_orders/1.json
  def destroy
    if (@transaction_order.order_status == "Unpaid")
      @transaction_order.destroy!

      respond_to do |format|
        format.html { redirect_to transaction_orders_url, notice: "Transaction order was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to transaction_order_url(@transaction_order), order_status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_order
      @transaction_order = TransactionOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_order_params
      params[:transaction_order][:order_status] = "Unpaid"
      params[:transaction_order][:user_id] = current_user.id
      params.require(:transaction_order).permit(:user_id, :consignee, :delivery_address, :delivery_phone, :delivery_postcode, :order_status)
    end
end
