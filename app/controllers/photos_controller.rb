class PhotosController < ApplicationController

  def index
    @photos = Photo.all
    respond_to do |format|
      format.html {}
      format.json {
        render :json =>
        {
          photos: @photos
        }, status: :ok
      }
    end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      respond_to do |format|
        format.json {
          render :json =>
          {
            photos: @photos
          }, status: :ok
        }
        format.html{ redirect_to photos_path }
      end
    else
      respond_to do |format|
        format.json{
          render :json =>
          {
            message: "Errors Found",
            errors: @photo.errors.full_messages
          }, status: :unprocessable_entity
        }
        format.html{ render :new }
      end
    end
  end


  private
  def photo_params
    params.require(:photo).permit(:title, :image)
  end

end
