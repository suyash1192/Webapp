class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    if @product && @product.destroy
      redirect_to root_path, status: :see_other
    else
      render json: { 'error': 'Product not found' }, status: :unprocessable_entity
    end
  end

  private
    def product_params
      params.permit(:title, :id)
    end
end
