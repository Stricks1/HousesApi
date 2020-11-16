class Image < ApplicationRecord
  belongs_to :place

  validates :image_url, presence: true, allow_blank: false
end
