json.extract! student, :id, :title, :name, :user_id, :link, :description, :created_at, :updated_at
json.url student_url(student, format: :json)