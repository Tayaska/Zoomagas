class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :address
      t.string :delivery_method
      t.string :payment_method
      t.decimal :total_price, precision: 10, scale: 2, default: 0.0  # для збереження суми

      t.timestamps
    end
  end
end

