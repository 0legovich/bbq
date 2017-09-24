class Photo < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :event, :user, :photo, presence: true

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> {where 'id IS NOT NULL'}
end
