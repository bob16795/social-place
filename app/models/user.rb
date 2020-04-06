class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :active_blocks, class_name: "Block", foreign_key: "blocker_id", dependent: :destroy
  has_many :passive_blocks, class_name: "Block", foreign_key: "blocked_id", dependent: :destroy
  
  has_many :active_likes, class_name: "Like", foreign_key: "user_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :blocking, through: :active_blocks, source: :blocked
  has_many :blockers, through: :passive_blocks, source: :blocker
  
  has_many :likes, through: :active_likes, source: :user

  def follow(other)
    active_relationships.create(followed_id: other.id)
  end

  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy
  end

  def following?(other)
    following.include?(other)
  end

  def block(other)
    active_blocks.create(blocked_id: other.id)
  end

  def unblock(other)
    active_blocks.find_by(blocked_id: other.id).destroy
  end

  def blocking?(other)
    blocking.include?(other)
  end
  
  def like(other)
    active_likes.create(post_id: other.id)
  end

  def unlike(other)
    active_likes.find_by(post_id: other.id).destroy
  end

  def likes?(other)
    active_likes.find_by(post_id: other.id) != nil
  end

  def self.search(search)
    if search
      where("username LIKE ?", "%#{search}%")
    else
      where("username LIKE ?", "%")
    end
  end
end
