class Streaming < ApplicationRecord
  belongs_to :user

  validates :title, :description, :image, :url, :date, presence: true

  mount_uploader :image, StreamingUploader
end
