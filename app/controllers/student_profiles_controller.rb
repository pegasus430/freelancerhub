class StudentProfilesController < ApplicationController
  before_action :set_user 
  before_action :set_student_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_works_and_educations
  layout :resolve_layout
  before_action :authenticate_user!

  # GET /student_profiles
  # GET /student_profiles.json
  def index
    @student_profile = @user.student_profile
    if @student_profile.present?
      redirect_to user_student_profile_path(@user, @student_profile)
    else
      redirect_to new_user_student_profile_path(@user)
    end  
  end
  
  # GET /student_profiles/1
  # GET /student_profiles/1.json
  def show
  end

  # GET /student_profiles/new
  def new
    @student_profile = @user.build_student_profile
    @student_profile.avatars.build
  end

  # GET /student_profiles/1/edit
  def edit
    @educations = @user.educations.order('created_at DESC')
    @works = @user.works.order('created_at DESC')
    @student_profile.avatars.build if @student_profile.avatars.blank?
  end

  # POST /student_profiles
  # POST /student_profiles.json
  def create
    @student_profile = @user.build_student_profile(student_profile_params)

    respond_to do |format|
      if @student_profile.save
        format.html { redirect_to "/manage", notice: 'Successfully created student profile!' }
        format.json { render :show, status: :created, location: @student_profile }
      else
        format.html { render :new, notice: 'Please check student profile info again!' }
        format.json { render json: @student_profile.errors, status: :unprocessable_entity }
        @student_profile.avatars.build
      end
    end
  end

  # PATCH/PUT /student_profiles/1
  # PATCH/PUT /student_profiles/1.json
  def update
    respond_to do |format|
      if @student_profile.update(student_profile_params)
        @user.update(first_name: params[:first_name], last_name: params[:last_name])
        format.html { redirect_to [@user, @student_profile], notice: 'Student profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_profile }
      else
        format.html { render :edit }
        format.json { render json: @student_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_profiles/1
  # DELETE /student_profiles/1.json
  def destroy
    @student_profile.destroy
    respond_to do |format|
      format.html { redirect_to student_profiles_url, notice: 'Student profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_profile
      @student_profile = StudentProfile.friendly.find(params[:id])
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end 
    
    def set_works_and_educations
       @educations = @user.educations
       @works = @user.works
       @education = Education.new
       @work = Work.new
    end    

    def resolve_layout
       if current_user
         if action_name =~ /create|update|new|edit/
          "dashboard"
         else
           "application"
          end   
       else
         "application"
      end
    end
     
    # Never trust parameters from the scary internet, only allow the white list through.
    def student_profile_params
      params.require(:student_profile).permit(:user_id, :slug, :education, :description, :location, :website, :age, :phone,
      :facebook, :linkedin, :twitter, :instagram, :avatars_attributes => [:id, :type, :assetable_id, :asstable_type, :attachment, :_destroy])
    end
end