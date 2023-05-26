class AddColumnsToMerchant < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :name, :string
    add_column :merchants, :uid, :string
    add_column :merchants, :provider, :string
  end
end
