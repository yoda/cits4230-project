# encoding: utf-8


require 'digest/sha2'
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  process :resize_to_limit => [300, 250]
  process :convert => 'png'

  def filename
    digest = Digest::SHA256.hexdigest(super)
    "#{digest}.png"
  end

end
