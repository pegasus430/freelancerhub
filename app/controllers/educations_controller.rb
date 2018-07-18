class EducationsController < ApplicationController
  before_action :set_education, only: [:show, :edit, :update, :destroy]

  # GET /educations
  def index
    @educations = Education.all
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  # GET /educations/1
  def show
  end

  # GET /educations/new
  def new
    @education = Education.new
  end

  # GET /educations/1/edit
  def edit
  end

  # POST /educations
  def create
    @education = Education.new(education_params)
      if @education.save
         render :partial => 'educations/education', :object => @education
       else
         render :new
      end

    #respond_to do |format|
    #  if @education.save
    #    format.html { redirect_to :back, notice: 'Added Education!' }
    #    format.json { render :show, status: :created, location: @html }
    #    format.js { flash.now[:notice] = "Added Education!" }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @html.errors, status: :unprocessable_entity }
    #  end
    #end
  end
  
  # PATCH/PUT /educations/1
  def update
    if @education.update(education_params)
      render :partial => 'educations/education', :object => @education
    else
      render :edit
    end
  end

  # DELETE /educations/1
  def destroy
    @education.destroy
    redirect_to :back, notice: 'Education was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_education
      @education = Education.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def education_params
      params.require(:education).permit(:degree, :degree_type, :degree_major, :school_name, :date_from, :date_to, :description, :user_id, :date_start, :date_end, :present)
    end
end
