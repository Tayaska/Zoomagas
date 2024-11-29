class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] # Лише авторизовані користувачі можуть створювати товари

  def index
    # Фільтрація за категорією
    if params[:category].present?
      @products = Product.where(category: params[:category])
    else
      @products = Product.all
    end

    # Пошук
    if params[:query].present?
      @products = @products.where("name LIKE ? OR category LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Товар успішно створено!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :image)
  end
end



