class AddVotingTokenToMembers < ActiveRecord::Migration[5.2]
  def up
    add_column :members, :voting_token, :string, unique: true
    Member.find_each { |member| member.regenerate_voting_token }
    change_column_null :members, :voting_token, false
  end

  def down
    remove_column :members, :voting_token
  end
end
