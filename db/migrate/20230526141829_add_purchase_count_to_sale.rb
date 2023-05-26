class AddPurchaseCountToSale < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :purchase_count, :integer
  end
end
