class CreateBlogoUsers < ActiveRecord::Migration
  def change
    table_name = 'blogo_users'

    create_table(table_name) do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index table_name, :email, unique: true
  end
end
