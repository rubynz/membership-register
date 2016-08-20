class AddTokenToMember < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :token, :string
    add_column :members, :token_updated_at, :datetime
  end
end
