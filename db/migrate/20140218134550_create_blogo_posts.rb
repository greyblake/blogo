class CreateBlogoPosts < ActiveRecord::Migration
  def change
    table_name = 'blogo_posts'

    create_table(table_name) do |t|
      t.integer :user_id      , null: false
      t.string  :url          , null: false
      t.string  :title        , null: false
      t.string  :markup_format, null: false
      t.text    :raw_content  , null: false
      t.text    :html_content , null: false
      t.boolean :published    , null: false, default: false
      t.date    :published_at , null: false
    end

    add_index table_name, :user_id
    add_index table_name, :url    , unique: true
    add_index table_name, :published_at
  end
end
