class CreateBlogoPosts < ActiveRecord::Migration
  def change
    table_name = "#{Blogo.table_name_prefix}posts"

    create_table(table_name) do |t|
      t.integer  :user_id      , null: false
      t.string   :permalink    , null: false
      t.string   :title        , null: false
      t.boolean  :published    , null: false
      t.datetime :published_at , null: false

      t.string   :markup_lang  , null: false
      t.text     :raw_content  , null: false

      t.text     :html_content , null: false
      t.text     :html_overiew , null: true

      t.string   :tags_string      , null: true
      t.string   :meta_description , null: false
      t.string   :meta_image       , null: true

      t.timestamps
    end

    add_index table_name, :user_id
    add_index table_name, :permalink, unique: true
    add_index table_name, :published_at
  end
end
