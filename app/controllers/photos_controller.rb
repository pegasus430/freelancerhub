class PhotosController < ApplicationController
  before_action :set_conversation
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = @conversation.photos.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = @conversation.photos.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to :back, notice: 'File was successfully uploaded.' }
        format.json { render :show, status: :created, location: [@conversation, @photo] }
      else
        error = @photo.errors[:image].join("") rescue "error"
        flash[:error] = error
        format.html { redirect_to conversation_path(@conversation)}
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'File was successfully uploaded.' }
        format.json { render :show, status: :ok, location: [@conversation, @photo] }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'File was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = @conversation.photos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image) rescue {}
    end

    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end
end
