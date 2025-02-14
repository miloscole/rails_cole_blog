class Category < ApplicationRecord
  has_and_belongs_to_many :articles
  validates :name, presence: true, uniqueness: true, length: 3..25
end
