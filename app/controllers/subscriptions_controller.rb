class SubscriptionsController < ApplicationController
  before_action :authenticate_user!#, except: [:new]
  before_action :redirect_to_signup, only: [:new]
  layout :resolve_layout
  def show
  end

  def new
    @coupon = current_user.user_coupons.where("coupon_validate_end_date > ? OR one_single_free_ad = ? " , Time.now, true ).last
  end

  def create
    customer = if current_user.stripe_id?
                 Stripe::Customer.retrieve(current_user.stripe_id)
               else
                 Stripe::Customer.create(email: current_user.email)
               end

    subscription = customer.subscriptions.create(
      source: params[:stripeToken],
      plan: params[:plan_type]
    )

    options = {
      stripe_id: customer.id,
      stripe_subscription_id: subscription.id,
    }

    # Only update the card on file if we're adding a new one
    options.merge!(
      card_last4: params[:card_last4],
      card_exp_month: params[:card_exp_month],
      card_exp_year: params[:card_exp_year],
      card_type: params[:card_brand]
    ) if params[:card_last4]

    current_user.update(options)
    redirect_to manage_path, notice: "Your subscription has been created."
  end

  def apply_coupon
     @coupon = Coupon.find_by(name: params[:coupon])

     if @coupon.present?
       if Time.now > @coupon.coupon_expired_date
          @flag = true
          flash[:notice] = "Coupon is expired"
       end

       if @coupon.status != "active"
          @flag = true
          flash[:notice] = "Coupon is expired"
       end

       if @coupon.user_coupons.count > @coupon.max_limit
          @flag = true
          flash[:notice] = "Coupon count is exceeded"
       end

       if current_user.user_coupons.find_by(coupon_id: @coupon.id)
          @flag = true
          flash[:notice] = "Coupon already exist or expired"
        end

       if @flag
          redirect_to manage_path and return
       end

       case @coupon.coupon_type
         when "Three Months Free"
            flash[:notice] =  'Three Months Free subscription has been created'
            current_user.user_coupons.create(coupon_id: @coupon.id, coupon_validate_start_date: Date.today , coupon_validate_end_date: Date.today + 3.months )

         when "Six Months Free"
           flash[:notice] =  'Six Months Free subscription has been created'
           current_user.user_coupons.create(coupon_id: @coupon.id, coupon_validate_start_date: Date.today , coupon_validate_end_date: Date.today + 6.months )
         when "One Single Free Ad"
           flash[:notice] =  'One single Free Ad subscription has been created'
           current_user.user_coupons.create(coupon_id: @coupon.id, one_single_free_ad: true )
         else
           flash[:notice] = "Invalid Coupon2"
       end
     else
        flash[:notice] = "Invalid Coupon1"
     end

     redirect_to manage_path
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil)
    redirect_to manage_path, notice: "Your subscription has been canceled."
  end

  private
    def resolve_layout
      if current_user.is_employer?
         "dashboard" 
       else
         "application"
      end  
    end

    def redirect_to_signup
      if !user_signed_in?
        session["user_return_to"] = new_subscription_path
        redirect_to new_user_registration_path
      end
    end
end