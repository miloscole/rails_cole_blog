class Article < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories

  validates :title, presence: true, length: 3..100
  validates :content, presence: true, length: 10..4000
end
