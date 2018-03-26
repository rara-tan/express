class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 255 }
  validates :job, length: { maximum: 30 }
  validates :residence, length: { maximum: 30 }
  validates :hobby, length: { maximum: 30 }
  has_many  :tweets
  has_many  :relationships
  has_many  :followings, through: :relationships, source: :follow
  has_many  :reverses_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many  :followers, through: :reverses_relationship, source: :user
  has_many  :likes
  has_many  :liking_tweets, through: :likes, source: :tweet
  has_many  :messages
  
  has_secure_password
  
  def follow(other_user)
    self.relationships.create(follow_id: other_user.id)
  end
  
  def unfollow(other_user)
    self.relationships.find_by(follow_id: other_user.id).destroy
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(tweet)
    self.likes.create(tweet_id: tweet.id)
  end
  
  def unlike(tweet)
    self.likes.find_by(tweet_id: tweet.id).destroy
  end
  
  def like?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end
end
