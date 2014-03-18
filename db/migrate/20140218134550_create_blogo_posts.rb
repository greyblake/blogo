class CreateBlogoPosts < ActiveRecord::Migration
  def change
    posts_table = "#{Blogo.table_name_prefix}posts"

    create_table(posts_table) do |t|
      t.integer  :user_id      , null: false
      t.string   :permalink    , null: false
      t.string   :title        , null: false
      t.boolean  :published    , null: false
      t.datetime :published_at , null: false

      t.string   :markup_lang  , null: false
      t.text     :raw_content  , null: false

      t.text     :html_content , null: false
      t.text     :html_overview, null: true

      t.string   :tags_string      , null: true
      t.string   :meta_description , null: false
      t.string   :meta_image       , null: true

      t.timestamps
    end

    add_index posts_table, :user_id
    add_index posts_table, :permalink, unique: true
    add_index posts_table, :published_at

    # NOTE: respond_to?(:add_foreign_key) does not work
    if defined?(Foreigner)
      users_table = "#{Blogo.table_name_prefix}users"
      add_foreign_key posts_table, users_table, column: :user_id
    end
  end
end
