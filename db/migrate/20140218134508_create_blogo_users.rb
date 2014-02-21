class CreateBlogoUsers < ActiveRecord::Migration
  def change
    table_name = "#{Blogo.table_name_prefix}users"

    create_table(table_name) do |t|
      t.string :name           , null: false
      t.string :email          , null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index table_name, :email, unique: true
  end
end
