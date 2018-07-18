class EmployerProfilesController < ApplicationController
  
  before_action :set_user
  before_action :set_employer_profile, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  # GET /employer_profiles
  # GET /employer_profiles.json
  def index
    @employer_profile = @user.employer_profile
    if @employer_profile.present? 
      redirect_to user_employer_profile_path(@user, @employer_profile)
    else
      redirect_to new_user_employer_profile_path(@user)
    end  
  end

  # GET /employer_profiles/1
  # GET /employer_profiles/1.json

  def show
    @employers = @user.employers.where("created_at <= ? AND created_at >= ?", Date.today + 40, Date.today - 40 ).order('created_at DESC')
  end

  # GET /employer_profiles/new
  def new
    if @user.employer_profile.nil?
      @employer_profile = @user.build_employer_profile
      @employer_profile.build_address
      @employer_profile.company_logos.build
    else
      @employer_profile = @user.employer_profile
      redirect_to user_employer_profile_path(@user, @employer_profile)
    end
  end

  # GET /employer_profiles/1/edit
  def edit
    @asset = Asset.where(type: "Asset::CompanyLogo", assetable_id: @employer_profile.id, assetable_type: "EmployerProfile").where("attachment_file_name is null") rescue nil      
    @employer_profile.company_logos.build if @employer_profile.company_logos.empty?
  end

  # POST /employer_profiles
  # POST /employer_profiles.json
  def create
    @employer_profile = @user.build_employer_profile(employer_profile_params)

    respond_to do |format|
      if @employer_profile.save
        format.html { redirect_to [@user, @employer_profile], notice: 'Employer profile was successfully created.' }
        format.json { render :show, status: :created, location: @employer_profile }
      else
        format.html { render :new }
        format.json { render json: @user.employer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employer_profiles/1
  # PATCH/PUT /employer_profiles/1.json
  def update
    respond_to do |format|
      if @employer_profile.update(employer_profile_params)
        @user.update(first_name: params[:first_name], last_name: params[:last_name])
        format.html { redirect_to [@user, @employer_profile], notice: 'Employer profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @employer_profile }
      else
        format.html { render :edit }
        format.json { render json: @user.employer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employer_profiles/1
  # DELETE /employer_profiles/1.json
  def destroy
    @employer_profile.destroy
    respond_to do |format|
      format.html { redirect_to user_employer_profiles_url(@user), notice: 'Employer profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employer_profile
      @employer_profile = EmployerProfile.friendly.find(params[:id])
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end  
    
     def resolve_layout
      if current_user && current_user.is_employer?
         if action_name =~ /new|create|edit|update/
           "dashboard" 
          else
          "application" 
         end    
      else
        "application"
      end  
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employer_profile_params
      params.require(:employer_profile).permit(:user_id, :slug, :company_name, :company_descripion, :website, 
      :facebook, :twitter, :linkedin, :instagram, :address_attributes => [:id, :email, :address, :landline, :addressable_id, :addressable_type ],
      :company_logos_attributes => [:id, :type, :assetable_id, :asstable_type, :attachment, :_destroy]
      )
    end
end