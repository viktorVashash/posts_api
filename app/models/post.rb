class Post < ApplicationRecord
  belongs_to :user
  has_many :post_views, class_name: "PostView", foreign_key: "post_id", dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

end
