class Asset::CompanyLogo < Asset
  has_attached_file :attachment,
		styles: {
		   thumb: "100X100!",
		   small: "200X200!",
		   original: '500x500#'
		},
		default_url: "https://www.kirkleescollege.ac.uk/wp-content/uploads/2015/09/default-avatar.png"
   
    validates_attachment :attachment, :content_type => { :content_type => [ "image/jpeg", 
    																																				"image/pjpeg", 
    																																				"image/jpg", 
    																																				"image/png", 
    																																				"image/png", 
    																																				"image/gif"] }
end    
    