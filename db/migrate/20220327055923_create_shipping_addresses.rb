class CreateShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_addresses do |t|

      t.integer :customer_id
      t.string :name, null: false
      t.string :postal_code, null: false
      t.text :address, null: false




      t.timestamps
    end
  end
end
