class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] # Лише авторизовані користувачі можуть створювати товари
  before_action :check_admin, only: [:new, :create] # Перевірка на адміністратора

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
      redirect_to @product, notice: 'Товар успішно доданий!'
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :category, :price, :description, :image)
  end

  def check_admin
    unless current_user&.role == 'admin'
      redirect_to root_path, alert: 'Тільки адміністратори можуть додавати товари.'
    end
  end
end




