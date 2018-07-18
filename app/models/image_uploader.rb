class ImageUploader < Shrine

  plugin :validation_helpers

    Attacher.validate do
      validate_extension_inclusion %w[jpg jpeg gif png]
      validate_mime_type_inclusion %w[image/jpeg image/gif image/png]
      validate_max_size 10*1024*1024
    end

end
