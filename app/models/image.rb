class Image < ActiveRecord::Base
  
  mount_uploader :image, ImageUploader
  
  def load_url!(url)
    self.image        = open(url)
    self.original_url = url
  end
  
  def url
    image.url
  end
  
  def self.from_url(url)
    image = self.new
    image.load_url! url
    image.save && image
  rescue
    nil
  end
  
end
