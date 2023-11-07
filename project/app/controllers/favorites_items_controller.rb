class FavoritesItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorite_products = current_user.favorite_products
  end


  def create
    current_user.favorite_products << Product.find(params[:product_id])
    respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "favorite relation was successfully created." }
        format.json { render :show, status: :created, location: @design }
    end
  end

  def destroy
    current_user.favorite_products.destroy(params[:product_id])
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: "favorite relation was successfully destroyed." }
      format.json {head :no_content}
    end
  end
end
