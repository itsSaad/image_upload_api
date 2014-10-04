class Photo < ActiveRecord::Base

  has_attached_file :image,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :dropbox_options => {}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def jsonObject
    {
      id: id,
      title: title,
      image_file_name: image_file_name,
      url: image.url,
      uploaded_at: created_at
    }
  end

end
