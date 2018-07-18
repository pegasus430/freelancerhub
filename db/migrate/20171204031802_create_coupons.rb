class CreateCoupons < ActiveRecord::Migration[5.0]

  def change
    create_table :coupons do |t|
      t.string   :name
      t.text     :description
      t.string   :coupon_type
      t.date     :coupon_validate_start_date
      t.date     :coupon_validate_end_date
      t.date     :coupon_expired_date
      t.integer  :max_limit
      t.string   :status

      t.timestamps
    end
  end
end
