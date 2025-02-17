class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy

  validates :message, presence: true

  after_create_commit { broadcast_refresh_to "comments" }
  after_destroy_commit { broadcast_refresh_to "comments" }
end
