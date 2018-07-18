class StudentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_profile
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  
  has_scope :by_category
  has_scope :by_diploma
  has_scope :by_language
  has_scope :by_state
  has_scope :by_city
  has_scope :by_title
  has_scope :by_pay

  # GET /students
  # GET /students.json
  def index
    @query = Student.where("user_id is not null").where(student_status: "Not Filled").where("created_at <= ? AND created_at >= ?", Date.today + 80, Date.today - 80 ).order('created_at DESC').ransack(params[:q])
    @students = @query.result.paginate(:page => params[:page], :per_page => 12)

    if params[:tag]
      @students = Student.tagged_with(params[:tag])
    end 
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
    @student.student_ad_pictures.build
  end

  # GET /students/1/edit
  def edit
    @student.student_ad_pictures.build if @student.student_ad_pictures.empty?
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to manage_path, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to manage_path, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def send_application
    @employer = Employer.find(params[:employer_id])
    @student = Student.find(params[:id])
    @interview = @student.interviews.build(employer_id: @employer.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id]) rescue nil
      create_add if @student.nil? 
    end

    def set_profile
       if current_user && current_user.is_student?
         if current_user.student_profile.blank?
             flash[:notice] = "Resume can't be blank"
             redirect_to "/manage" and return
          end  
      end   
    end
    def create_add
       flash[:notice] = "Please create your add"
       redirect_to "/manage" and return 
    end 
    
     def resolve_layout
      if current_user && current_user.is_student
         if action_name =~ /new|edit/  
           "dashboard" 
          else
          "application" 
         end    
      else
        "application"
      end  
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:title, :name, :user_id, :link, :description, :tag_list, :city, 
                                      :student, :zip_code, :city, :state, :country, :diploma, :category, 
                                      :spoken_languages, :avatar, :status, :student_status, :pay, 
                                      :student_ad_pictures_attributes => [:id, :type, :assetable_id, :asstable_type, :attachment, :_destroy] )
    end
end
