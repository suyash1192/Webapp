class CreateProduct < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.decimal :price, default: 0.0

      t.timestamps
    end
  end
end
