class Asset < ApplicationRecord

  belongs_to :assetable, polymorphic: true,  optional: true
  delegate :url, to: :attachment
end
