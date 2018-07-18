class Conversation < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  # belongs_to :user
  has_many :personal_messages, -> { order(position: :asc) }, dependent: :destroy
  has_many :interviews
  
  validates :author, uniqueness: {scope: :receiver}

  scope :participating, -> (user) do
    where("(conversations.author_id = ? OR conversations.receiver_id =?)", user.id, user.id)
  end

  def participates?(user)
    author == user || receiver == user
  end

  scope :between, -> (sender_id, receiver_id) do
    where(author_id: sender_id, receiver_id: receiver_id).or(where(author_id: receiver_id, receiver_id: sender_id)).limit(1)
  end
  
  has_many :photos
  #has_many :interviews
  
  def opposed_user(user)
    user == receiver ? author : receiver
  end
end