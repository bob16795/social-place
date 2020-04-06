class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 } # max length of post
  default_scope -> { order(created_at: :desc) } # newest posts first

  has_many :passive_likes, class_name: "Like", foreign_key: "post_id", dependent: :destroy

  has_many :likes, through: :passive_likes, source: :post
  def self.search(search)
    if search
      where("content LIKE ?", "%#{search}%")
    else
      where("content LIKE ?", "%")
    end
  end
end
