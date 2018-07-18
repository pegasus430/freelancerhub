class CouponSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :coupon_type, :coupon_validate_start_date, :coupon_validate_end_date, :coupon_expired_date, :max_limit, :status
end
