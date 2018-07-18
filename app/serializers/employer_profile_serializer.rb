class EmployerProfileSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :slug, :company_name, :company_descripion, :website, :address_id, :facebook, :twitter, :linkedin, :instagram
end
