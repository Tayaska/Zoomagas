class Cart < ApplicationRecord
  belongs_to :user  # кожен кошик належить користувачу
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product)
    # Знаходимо або ініціалізуємо запис для товару в кошику
    cart_item = cart_items.find_or_initialize_by(product_id: product.id)

    # Якщо quantity ще не задано, ініціалізуємо його значенням 0
    cart_item.quantity ||= 0
    cart_item.quantity += 1

    # Спробуємо зберегти зміни
    if cart_item.save
      Rails.logger.debug "Cart Item saved successfully: #{cart_item.inspect}"
    else
      Rails.logger.debug "Error saving Cart Item: #{cart_item.errors.full_messages.join(', ')}"
    end
  end
  end








