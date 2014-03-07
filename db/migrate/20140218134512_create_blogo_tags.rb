class CreateBlogoTags < ActiveRecord::Migration
  def change
    tags_table = "#{Blogo.table_name_prefix}tags"

    create_table(tags_table) do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index tags_table, :name, unique: true
  end
end
