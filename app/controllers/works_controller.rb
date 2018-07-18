class WorksController < ApplicationController
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  # GET /works
  def index
    @works = Work.all
  end

  # GET /works/1
  def show
  end

  # GET /works/new
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
   def create
    @work = Work.new(work_params)

    if @work.save
      flash[:notice] = 'Work was successfully created.'
      render :partial => 'works/work', :object => @work
    else
      render :new
    end

    #respond_to do |format|
    #  if @work.save
    #    format.html { redirect_to :back, notice: 'Added Work Experience!' }
    #    format.json { render :show, status: :created, location: @html }
    #    format.js { flash.now[:notice] = "Added Work Experience!" }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @html.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /works/1
  def update
    if @work.update(work_params)
      render :partial => 'works/work', :object => @work
    else
      render :edit
    end
  end

  # DELETE /works/1
  def destroy
    @work.destroy
    redirect_to :back, notice: 'Work was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def work_params
      params.require(:work).permit(:company_name, :position, :date_from, :date_to, :description, :city, :state, :country, :user_id, :date_start, :date_end, :present)
    end
end
