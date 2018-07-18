class User < ApplicationRecord
  has_secure_password

  has_many :notifications, :foreign_key => :recipient_id
  has_many :conversations, :foreign_key => :sender_id
  # has_many :conversations, :foreign_key => :sender_id, through: :conversation_users
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :personal_messages, dependent: :destroy
  has_many :charges
  has_many :interviews
  has_many :educations
  has_one  :employer_profile
  has_many :employers
  has_many :students
  has_many :interviews
  has_one  :student_profile
  has_many :works
  has_many :user_coupons
  has_many :interviews, foreign_key: :student_id
  has_many :applied_jobs, through: :interviews, source: :employer, class_name: "Employer", dependent: :destroy
  
  before_create :generate_token
  validates :email, uniqueness: true
  validates :password, presence: true, confirmation: true, :length => {:within => 6..40}, :on => :create
  validates :password, confirmation: true, :length => {:within => 6..40}, :allow_blank => true, :on => :update

  after_destroy :delete_association
  before_save :password_update
  
  def generate_token
    self.token = SecureRandom.hex
  end
  
  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end
  
  def subscribed?
    stripe_subscription_id?
  end
  
  # def send_password_reset
  #   generate_rest_password_token(:reset_password_token)
  #   self.reset_password_sent_at = Time.zone.now
  #   save!
  #   PasswordResetsMailer.password_reset(self).deliver
  # end

  # def generate_rest_password_token(column)
  #   begin
  #     self[column] = SecureRandom.urlsafe_base64
  #   end while User.exists?(column => self[column])
  # end
  
  scope :available, ->{where(is_employer: true)}
  
  #facebook 
  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.name = auth.info.name
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def delete_association
    if self.is_employer?
      self.employer_profile.delete if self.employer_profile.present?
      self.employers.delete_all if self.employers.present?
      self.interviews.delete_all if self.interviews.present?
      self.notifications.delete_all if self.notifications.present?
      self.authored_conversations.delete_all if self.authored_conversations.present?
      self.received_conversations.delete_all if self.received_conversations.present?
      self.personal_messages.delete_all if self.personal_messages.present?
      self.user_coupons.delete_all if self.user_coupons.present?
    end

    if self.is_student?
      self.student_profile.delete if self.student_profile.present?
      self.students.delete if self.students.present?
      self.applied_jobs.delete_all if self.applied_jobs.present?
      self.notifications.delete_all if self.notifications.present?
      self.authored_conversations.delete_all if self.authored_conversations.present?
      self.received_conversations.delete_all if self.received_conversations.present?
      self.educations.delete_all if self.educations.present?
      self.works.delete_all if self.works.present?
      self.personal_messages.delete_all if self.personal_messages.present?
    end
  end

  def password_update
    unless self.password.nil?
      if password == password_confirmation
        self.password = password
      end
    end
  end
  
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_many :notifications, :foreign_key => :recipient_id
end