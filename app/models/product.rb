class Product < ApplicationRecord
  # Асоціації
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :comments, dependent: :destroy

  # Завантаження зображень
  has_one_attached :image

  # Валідації
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true

  # Додаткові методи (за потреби)
  def in_stock?
    stock > 0
  end
end

