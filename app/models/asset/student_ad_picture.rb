class Asset::StudentAdPicture < Asset

  has_attached_file :attachment,
    styles: {
        thumb: "100X100!",
        small: "200X200!",
        medium: '300x300!',
        original: '500x500!'
      
    },
    default_url: "/images/freelancerhub_login_icon.svg"
   
  validates_attachment  :attachment,  
                        :content_type => { :content_type => %w(image/jpeg image/pjpeg image/jpg image/png image/gif) }
end