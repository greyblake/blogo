class CreateBlogoTaggings < ActiveRecord::Migration
  def change
    table_name = 'blogo_taggings'
    create_table(table_name) do |t|
      t.integer :post_id, null: false
      t.integer :tag_id , null: false
    end

    add_index table_name, [:tag_id, :post_id], unique: true
  end
end
