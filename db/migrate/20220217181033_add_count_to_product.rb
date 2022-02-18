class AddCountToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :count, :integer, default: 1, null: false
  end
end
