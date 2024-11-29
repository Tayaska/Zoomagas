class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = current_user.cart
    @cart_items = @cart.cart_items
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @cart = current_user.cart
    @cart_items = @cart.cart_items


    if @cart_items.empty?
      flash.now[:alert] = "Ваш кошик порожній!"
      render :new and return
    end

    @order.total_price = @cart_items.sum { |item| item.quantity * item.product.price }
    # Створення order_items з cart_items
    @cart_items.each do |item|
      @order.order_items.build(product: item.product, quantity: item.quantity, price: item.product.price)
    end

    if @order.save
      puts "jffhvfjvfnjvn"
      # Очищення кошика після створення замовлення
      @cart.cart_items.destroy_all
      redirect_to root_path, notice: "Ваше замовлення успішно оформлено!"
    else
      puts "jffhvfjvfnjvn"
      flash.now[:alert] = "Не вдалося оформити замовлення. Перевірте введені дані."
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :delivery_method, :payment_method, :delivery_address, :total_price, :delivery_address, :comment)
  end
end







