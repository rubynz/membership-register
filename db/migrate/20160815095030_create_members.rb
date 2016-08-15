class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :members, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :full_name, index: true
      t.datetime :joined_at
      t.string :email, index: true
      t.string :address
      t.json :data, null: false, default: {}

      t.timestamps
    end
  end
end
