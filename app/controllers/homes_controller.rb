class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  #def index
  #  @homes = Home.all
  #end

  # GET /employers
  # GET /employers.json
  def index
     #@employers = apply_scopes(Employer).where("user_id is not null").where(employer_status: "Not Filled").paginate(:page => params[:page], :per_page => 15).order('created_at DESC').recent
     if current_user.present? && current_user.is_employer?
       @query = Student.where("user_id is not null").where(student_status: "Not Filled").where("created_at <= ? AND created_at >= ?", Date.today + 40, Date.today - 40 ).order('created_at DESC').ransack(params[:q])
       @students = @query.result.paginate(:page => params[:page], :per_page => 12)
     elsif current_user.present? && current_user.is_student?
       @query = Employer.where("user_id is not null").where(employer_status: "Not Filled").where("created_at <= ? AND created_at >= ?", Date.today + 40, Date.today - 40 ).order('created_at DESC').ransack(params[:q])
       @employers = @query.result.includes(:applications).paginate(:page => params[:page], :per_page => 12)
     else
       @query = Student.where("user_id is not null").where(student_status: "Not Filled").where("created_at <= ? AND created_at >= ?", Date.today + 40, Date.today - 40 ).order('created_at DESC').ransack(params[:q])
       @students = @query.result.paginate(:page => params[:page], :per_page => 12)
    end
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def set_language
    if params[:language] == "french"
      session[:language]  = "french"
    else
      session[:language]  = "english"
    end  
    redirect_to "?language=#{session[:language] }"
  end    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.fetch(:home, {})
    end
end
