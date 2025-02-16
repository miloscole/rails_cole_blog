class AllowNullOnArticleContent < ActiveRecord::Migration[8.0]
  def up
    change_column :articles, :content, :text, null: true
  end
end
