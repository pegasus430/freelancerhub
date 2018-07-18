class Photo < ApplicationRecord
  include ImageUploader[:image]

  belongs_to :conversation

  validates :image , :presence => true
end
