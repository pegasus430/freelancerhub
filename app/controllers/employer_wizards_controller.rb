require 'wizard/employer'
class EmployerWizardsController < ApplicationController
  authorize_resource :class => false

  layout :resolve_layout
  before_action :authenticate_user!
  before_action :verify_job_permission
  before_action :load_employer_wizard, except: %i(validate_step)

  def validate_step
    current_step = params[:current_step]
    @employer_wizard = wizard_employer_for_step(current_step)
    @employer_wizard.employer.attributes = employer_wizard_params
    session[:employer_attributes] = @employer_wizard.employer.attributes
    p "#############################"
    p session[:employer_attributes]
    p "#############################"
    if @employer_wizard.valid?
      next_step = wizard_employer_next_step(current_step)
      employer = Employer.find(params[:id]) rescue nil
       if employer.present?
         update and return unless next_step
         redirect_to action: next_step , id: params[:id]
       else
         create and return unless next_step
         redirect_to action: next_step
      end
    else
      render current_step
    end
  end

  def create
     #d = employer_wizard_params[:start_date].split("/")
     #dt = "#{d[1]}/#{d[0]}/#{d[2]}"
     #date = DateTime.parse(dt) rescue nil
     #@employer_wizard.employer.start_date = date
    if @employer_wizard.employer.save
      session[:employer_attributes] = nil
      redirect_to employers_path, notice: 'Job successfully created!'
    else
       redirect_to({ action: Wizard::Employer::STEPS.first }, alert: 'There were a problem when creating the employer.')
    end
  end

  def update
       employer = Employer.find(params[:id]) rescue nil
       #d = employer_wizard_params[:start_date].split("/")
       #dt = "#{d[1]}/#{d[0]}/#{d[2]}"
       #date = DateTime.parse(dt) rescue nil
       #@employer_wizard.employer.start_date = date
      if employer.update(session[:employer_attributes])
        session[:employer_attributes] = nil
        redirect_to employers_path, notice: 'Job successfully created!'
      else
        redirect_to({ action: "#{Wizard::Employer::STEPS.first}" }, alert: 'There were a problem when creating the employer.')
       end
    end

  private

  def load_employer_wizard
    @employer_wizard = wizard_employer_for_step(action_name)
  end

  def wizard_employer_next_step(step)
    Wizard::Employer::STEPS[Wizard::Employer::STEPS.index(step) + 1]
  end

  def wizard_employer_for_step(step)
    raise InvalidStep unless step.in?(Wizard::Employer::STEPS)
    employer = Employer.find(params[:id]) rescue nil
    if employer.present?
       session[:employer_attributes] = employer.attributes if session[:employer_attributes].nil?
    end
    "Wizard::Employer::#{step.camelize}".constantize.new(session[:employer_attributes])
  end

  def verify_job_permission
    if current_user.present?
      user_coupon = current_user.user_coupons.last rescue nil
      stripe = Stripe::Customer.retrieve(current_user.stripe_id) rescue nil
      date_int = stripe["subscriptions"]["data"][0]["current_period_end"] rescue nil
      date = Time.at(date_int) rescue nil

      if date.present? &&  date < Date.today
        @message ="Sorry your subscription has expired"
      elsif  user_coupon && user_coupon.one_single_free_ad?
         @message = "Sorry your subscription limit exceeded"
        render "job_access"  if current_user.employers.count <= 1
      elsif user_coupon && user_coupon.coupon_validate_end_date < Date.today
        @message ="Sorry your subscription has expired"
        render "job_access"
      elsif date.nil? && user_coupon.nil?
        @message ="Before create job please subscribe."
        redirect_to manage_path, notice: 'Before create job please subscribe.'
      end
    end
  end

  def employer_wizard_params
    params.require(:employer_wizard).permit(:title, :name, :user_id, :link, :description, :category, :responsibility, :requirement, :work_schedule, :diploma, :written_languages, :spoken_languages, :level_of_study, :zip_code, :start_date, :url, :image_url, :city, :state, :pay, :long_description, :years_of_experience, :instagram, :facebook, :company_website, :linkedin, :additional_link, :avatar, :status, :employer_status, :job_duration, :company_job_logos_attributes => [:id, :type, :assetable_id, :asstable_type, :attachment, :_destroy])
  end

  def resolve_layout
    if current_user && current_user.is_employer?
      "dashboard"
    else
      "application"
    end
  end

  class InvalidStep < StandardError; end
end