class CreateUserCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :user_coupons do |t|
      t.integer   :user_id
      t.integer   :coupon_id
      t.date      :coupon_validate_start_date
      t.date      :coupon_validate_end_date
      t.boolean   :one_single_free_ad
      t.timestamps
    end
  end
end
