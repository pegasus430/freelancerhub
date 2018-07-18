class StudentProfile < ApplicationRecord
	extend FriendlyId
    
  friendly_id :education, use: :slugged 
    
  belongs_to :user
    
  has_many :avatars, as: :assetable, class_name: "Asset::Avatar"
  accepts_nested_attributes_for :avatars
    
  validates :education, presence: true
end
