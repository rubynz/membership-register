class AddPhoneToMembers < ActiveRecord::Migration[8.1]
  def change
    add_column :members, :phone, :string
  end
end
