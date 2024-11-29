class AddDetailsToOrders < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:orders, :delivery_address)
      add_column :orders, :delivery_address, :string
    end

    unless column_exists?(:orders, :delivery_method)
      add_column :orders, :delivery_method, :string
    end

    unless column_exists?(:orders, :payment_method)
      add_column :orders, :payment_method, :string
    end

    unless column_exists?(:orders, :total_price)
      add_column :orders, :total_price, :decimal, precision: 10, scale: 2
    end
  end
end

