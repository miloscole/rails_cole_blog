class Article < ApplicationRecord
  has_rich_text :content

  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: 3..100
  validates :content, presence: true, length: 10..4000

  def self.with_categories_and_pagination(page, per_page)
    self
      .paginate(page: page, per_page: per_page)
      .order(updated_at: "desc")
      .includes(:user, :categories, :rich_text_content)
  end

  def load_comments
    self
      .comments
      .where(parent_id: nil)
      .order(created_at: "desc")
      .includes(replies: :user)
  end
end
