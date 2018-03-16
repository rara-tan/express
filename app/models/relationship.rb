class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  
  varidates :user_id, presence: true
  varidates :follow_id, presence: true
end
