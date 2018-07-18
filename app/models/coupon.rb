class Coupon < ApplicationRecord

  has_many :user_coupons

  validates :name, presence: true
  validates :coupon_type, presence: true
  validates :coupon_expired_date, presence: true
  validates :max_limit, presence: true
end
