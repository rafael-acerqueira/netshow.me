class Streaming < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum status: [:confirmed, :done, :started]

  belongs_to :user

  validates :title, :description, :image, :url, :date, presence: true

  mount_uploader :image, StreamingUploader

  private
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
