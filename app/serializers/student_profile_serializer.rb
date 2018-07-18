class StudentProfileSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :slug, :education, :text, :location, :"website.string", :age, :phone, :facebook, :linkedin, :twitter, :instagram
end
