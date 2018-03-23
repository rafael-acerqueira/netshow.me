class StreamingUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  version :preview do
    process :resize_to_fill => [200, 140]
  end

  version :card do
    process :resize_to_fill => [246, 163]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore.pluralize}/#{mounted_as}"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end
end
