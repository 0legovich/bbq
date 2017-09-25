class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos

  validates :title, :user, :adress, :datetime, presence: true
  validates :title, length: { maximum: 255 }

  def visitors
    (subscribers = [user]).uniq
  end

  def pincode_valid?(pin2check)
    pincode == pin2check
  end
end
