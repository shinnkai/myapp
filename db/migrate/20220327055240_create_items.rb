class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :explanation, null: false
      t.integer :tax_out_price, null: false
      t.string :image, null: false
      t.timestamps
    end
  end
end
