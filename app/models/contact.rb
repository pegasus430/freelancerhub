class Contact < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :content
  validates :content,   length: { in: 15..2000 }

  def headers
    {
      subject: 'Contact Form',
      to: ENV["CONTACT_SUPPORT_EMAIL"],
      from: %("#{name}" <#{email}>)
    }
  end
end