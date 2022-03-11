class ProductsController < ApplicationController
  before_action :verify_product, only: [:update]
  skip_before_action :verify_authenticity_token


  def index
    @products = Product.all
    render json: @products, status: :ok
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      # redirect_to root_path
      render json: @product, status: :ok 
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if params[:task] == "add"
      count = @product.count + 1
    elsif params[:task] == "remove"
      count = @product.count - 1
    else
      render json: { 'error': 'Invalid Params' }, status: :unprocessable_entity
      return
    end
    if @product.update(count: count)
      # respond_to do |format|
        # format.json  { render :json => @product }
        render json: @product, status: :ok
      # end
    else
      render json: { 'error': 'Updation error' }, status: :unprocessable_entity
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
      params.permit(:title, :id, :task)
    end

    def verify_product
      render json: { 'error': 'Product not found' } unless product
    end

    def product
      @product ||= Product.find_by(id: product_params[:id])
    end
end
