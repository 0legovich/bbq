class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  validates :title, :user, :adress, :datetime, presence: true
  validates :title, length: { maximum: 255 }
end
