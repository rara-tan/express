class Message < ApplicationRecord
  belongs_to :user
  belongs_to :partner, class_name: 'User'
  validates  :content, presence: true, length: { maximum: 255 }
  validates  :user_id, presence: true
  validates  :partner_id, presence: true
end
