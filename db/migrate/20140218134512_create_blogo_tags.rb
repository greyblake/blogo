class CreateBlogoTags < ActiveRecord::Migration
  def change
    table_name = "#{Blogo.table_name_prefix}tags"

    create_table(table_name) do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index table_name, :name, unique: true
  end
end
