# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  
  storage :file
 
  def store_dir
    "User/"
  end

  
   def scale(width, height)
     process :scale => [260, 260]
   end

  
   def extension_white_list
     %w(jpg)
   end

 
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end
