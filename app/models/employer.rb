class Employer < ActiveRecord::Base
  belongs_to :user
  
  has_many :company_job_logos, as: :assetable, class_name: "Asset::CompanyJobLogo"
  accepts_nested_attributes_for :company_job_logos
    
  has_many :interviews
  has_many :applications, through: :interviews, source: :student, foreign_key: :student_id, dependent: :destroy

  # CATEGORY_LIST = ["Accounting", "Administration",  "Agriculture", "Automotive", "Banking & Finance", "Biology",
  #                  "Business", "Coding", "Computer Science", "Construction", "Consulting", "Consumer Packaged Goods",
  #                  "Customer Service", "Diversity", "Educator & Education", "Engineering", "Entertainment", "Fashion, Design & Beauty",
  #                  "Finance", "Fitness & Recreation", "Graphic Design", "Government", "Healthcare", "Hospitality",
  #                  "Human Resources", "Insurance", "Journalism", "Law", "Logistics", "Management", "Marketing",  "Media",
  #                  "Non-Profit", "Oil & Gas", "Operations", "Pharmaceuticals", "Public Relations", "Real Estate", "Retail", "Sales",
  #                  "Science & Research", "Skilled Trades", "Software Engineering", "Tax", "Technology", "Telecommunication","Travel", "Other", "None"]
  CATEGORY_LIST = ["T-Shirt Design", "Logo Design","Misc Freelance Artwork"]
  EDUCATION_LIST = ["Any", "Baccalaureate", "PhD","Masters", "Doctorate", "Associate", "High School", "Attestation of College Studies", "None"]
  LANGUAGE_LIST = ["Primary Lanugage", "English", "French", "Spanish", "Hindi", "Japanese", "Manderin", "Russian", "Arabic", "Portuguese", "Bengali" ]
  STATE_LIST = ["Co-op", "Early Career Job", "Entry Level Job","Internship", "Work And Study Job", "Summer Job"]
  WORK_SCHEDULE = ["Full Time", "Part Time", "Flexible Hours"]
  PAY_LIST = ["Paid", "Unpaid", "To be discussed"]
  MONTH_LIST = ["Job Duration", "Undetermined", "1-2 months", "3-4 months", "5-6 months", "6+ months", "1 year"]
  GRADUATED_YEAR = [" ", "Graduated", "1st Year", "2nd Year", "3rd Year", "4th Year"]
  EMPLOYER_STATUS = ["Not Filled", "Filled"]

  scope :recent, lambda{ where(['created_at > ?', 30.days.ago]) }
  scope :by_diploma, -> diploma { where(:diploma => diploma) }
  scope :by_category, -> category { where(:c2ategory => category) }
  scope :by_language, -> spoken_languages { where(:spoken_languages => spoken_languages) }
  scope :by_state, -> state{ where(:state => state) }
  scope :by_city, -> city{ where(:city => city) }
  scope :by_title, -> title{ where(:title => title) }
  scope :by_pay, -> pay{ where(:pay => pay) }
  scope :by_work_schedule, -> work_schedule{ where(:work_schedule => work_schedule) }
  scope :by_state, -> state{ where(:state => state) }

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    original: '500x500#'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end