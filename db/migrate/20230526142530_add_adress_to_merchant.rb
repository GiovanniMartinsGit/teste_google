class AddAdressToMerchant < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :merchant_address, :string
  end
end
