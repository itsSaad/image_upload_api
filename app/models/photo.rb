class Photo < ActiveRecord::Base

  attr_accessor :image_data
  if Rails.env == 'production'
    has_attached_file(:image, storage: :dropbox, dropbox_credentials: Rails.root.join("config/dropbox.yml"), dropbox_visibility: 'public')
  else
    has_attached_file(:image)
  end
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  before_save :decode_image_data

  def jsonObject
    {
      id: id,
      title: title,
      image_file_name: image_file_name,
      url: image.url,
      uploaded_at: created_at
    }
  end

  def decode_image_data
  	# If image_data is present, it means that we were sent an image over
  	# JSON and it needs to be decoded.  After decoding, the image is processed
  	# normally via Paperclip.
  	if self.image_data.present?
  		data = StringIO.new(Base64.decode64(self.image_data))
  		data.class.class_eval {attr_accessor :original_filename, :content_type}
  		data.original_filename = self.title.to_s + ".jpg"
  		data.content_type = "image/jpeg"

  		self.image = data
  	end
  end
end
