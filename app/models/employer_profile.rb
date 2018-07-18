class EmployerProfile < ApplicationRecord
  extend FriendlyId

  friendly_id :company_name, use: :slugged

  belongs_to :user

  has_one :address, as: :addressable 
  accepts_nested_attributes_for :address, allow_destroy: true

  has_many :company_logos, as: :assetable, class_name: "Asset::CompanyLogo"
  accepts_nested_attributes_for :company_logos

  validates :company_name, presence: true
  validates :company_descripion, presence: true 
  validates :website, presence: true
end
