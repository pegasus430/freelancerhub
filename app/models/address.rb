class Address < ApplicationRecord

  belongs_to :addressable, polymorphic: true, optional: true
    
  validates :email, presence: true
  #validates :address, presence: true
end
