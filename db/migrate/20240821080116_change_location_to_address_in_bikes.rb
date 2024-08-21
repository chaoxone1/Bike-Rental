class ChangeLocationToAddressInBikes < ActiveRecord::Migration[7.1]
  def change
    rename_column :bikes, :location, :address
    change_column :bikes, :address, :text
  end
end
