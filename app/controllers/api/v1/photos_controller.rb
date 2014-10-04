class Api::V1::PhotosController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    @photos = Photo.all
    render :json =>
    {
      photos: @photos.map { |e| e.jsonObject}
    }, status: :ok
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      render :json =>
      {
        photos: @photos
      }, status: :ok
    else
      render :json =>
      {
        message: "Errors Found",
        errors: @photo.errors.full_messages
        }, status: :unprocessable_entity
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :image)
  end

end
