class Article < ApplicationRecord
  has_rich_text :content
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: 3..100
  validates :content, presence: true, length: 10..4000
end
