# app/models/cart_item.rb
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  # Метод для оновлення кількості
  def update_quantity(new_quantity)
    update(quantity: new_quantity) if new_quantity >= 1
  end
end

