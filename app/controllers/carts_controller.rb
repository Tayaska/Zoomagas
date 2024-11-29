class CartsController < ApplicationController
  before_action :authenticate_user!

  # app/controllers/carts_controller.rb
  # У контролері
  def show
    @cart = Rails.cache.fetch("cart_#{current_user.id}", expires_in: 12.hours) do
      current_user.cart || current_user.create_cart
    end

    # Сортуємо товари за їх ID або за іншою логікою
    @cart_items = @cart.cart_items.order(:created_at) # або :id
  end



  def add
    product = Product.find(params[:product_id])
    cart = current_user.cart || current_user.create_cart

    # Додаємо товар до кошика користувача
    cart_item = cart.cart_items.find_by(product: product)
    if cart_item
      cart_item.increment!(:quantity) # Збільшуємо кількість, якщо товар уже є в кошику
    else
      cart.cart_items.create(product: product, quantity: 1)
    end

    redirect_to cart_path, notice: "Товар додано до кошика"
  end

  def remove
    cart_item = current_user.cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: "Товар видалено з кошика"
  end

  def clear
    current_user.cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Ваш кошик очищено"
  end

  def checkout
    @cart = current_user.cart
    @cart_items = @cart.cart_items
  end

  def update_quantity
    cart_item = current_user.cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity > 0
      cart_item.update(quantity: new_quantity)
      flash[:notice] = "Кількість товару оновлено"
    else
      cart_item.destroy # Видаляємо товар, якщо кількість <= 0
      flash[:notice] = "Товар видалено з кошика"
    end

    redirect_to cart_path
  end



end









