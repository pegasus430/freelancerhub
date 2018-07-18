class PersonalMessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :conversation_id, :user_id, :position
end