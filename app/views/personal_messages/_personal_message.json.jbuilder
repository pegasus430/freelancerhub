json.extract! personal_message, :id, :body, :conversation_id, :user_id, :position, :created_at, :updated_at
json.url personal_message_url(personal_message, format: :json)