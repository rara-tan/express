class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :introduction, length: { maximum: 500 }
  has_many  :tweets
  has_many  :rerationships
  has_many  :followings, through: :relationships, source: :follow
  has_many  :reverses_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many  :followers, through: :reverses_relationship, source: :user
  has_secure_password
end
