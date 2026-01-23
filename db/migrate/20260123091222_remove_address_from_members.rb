class RemoveAddressFromMembers < ActiveRecord::Migration[8.1]
  def change
    remove_column :members, :address, :string
  end
end
