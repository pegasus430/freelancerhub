class Student < ActiveRecord::Base
  #SHOW STUDENTS FROM 30 DAYS AGO. 
  scope :recent, lambda{ where(['created_at > ?', 30.days.ago]) }
  
  belongs_to :user
   
  has_many :student_ad_pictures, as: :assetable, class_name: "Asset::StudentAdPicture"
  accepts_nested_attributes_for :student_ad_pictures

  CATEGORY_LIST = ["T-Shirt Design", "Logo Design","Misc Freelance Artwork"]
  DIPLOMA_LIST = ["Bachelor", "PhD", "Masters", "Doctorate", "Associate", "High School", "Attestation of College Studies", "Diploma of College Studies",  "None"]
  STUDENT_STATUS = ["Not Filled", "Filled"]
  PAY_LIST = ["Paid", "Unpaid", "To be discussed"]
  DEGREE_LIST = [ "Baccalaureate", "PhD","Masters", "Doctorate", "Associate", "High School", "Attestation of College Studies", "None"]
  
  acts_as_taggable # Alias for acts_as_taggable_on :tags
    
  scope :by_diploma, -> diploma { where(:diploma => diploma) }
  scope :by_category, -> category { where(:category => category) }
  scope :by_language, -> spoken_languages { where(:spoken_languages => spoken_languages) }
  scope :by_state, -> state{ where(:state => state) }
  scope :by_city, -> city{ where(:city => city) }
  scope :by_title, -> title{ where(:title => title) }
  scope :by_pay, -> pay{ where(:pay => pay) }
  scope :by_work_schedule, -> work_schedule{ where(:work_schedule => work_schedule) }
  scope :by_degree, -> degree{ where(:degree => degree) }
  
  #paperclip
  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300#',
    original: '500x500#'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end