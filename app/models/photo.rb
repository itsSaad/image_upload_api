class Photo < ActiveRecord::Base

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def jsonObject
    {
      id: id,
      title: title,
      url: image.url,
      uploaded_at: created_at
    }
  end

end
