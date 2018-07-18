class Education < ApplicationRecord
  belongs_to :users, optional: true
end
