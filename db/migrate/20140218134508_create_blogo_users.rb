class CreateBlogoUsers < ActiveRecord::Migration
  def change
    users_table = "#{Blogo.table_name_prefix}users"

    create_table(users_table) do |t|
      t.string :name           , null: false
      t.string :email          , null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index users_table, :email, unique: true
  end
end
