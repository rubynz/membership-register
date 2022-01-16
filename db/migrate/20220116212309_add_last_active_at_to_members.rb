class AddLastActiveAtToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :last_active_at, :timestamp, null: true
  end
end
