class Tweet < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  attr_reader :search_string
end
