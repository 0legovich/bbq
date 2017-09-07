class Event < ActiveRecord::Base
  belongs_to :user

  validates :title, :user, :adress, :datetime, presence: true
  validates :title, length: { maximum: 255 }
end
