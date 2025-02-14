class CreateArticlesCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :articles_categories, id: false do |t|
      t.belongs_to :article, null: false
      t.belongs_to :category, null: false
    end
  end
end
