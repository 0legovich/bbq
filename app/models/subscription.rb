class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :event, presence: true
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9_.\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+\z/, unless: 'user.present?'

  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'

  before_create :check_email

  def check_email
    if !user.present? && !User.find_by_email(self.user_email).nil?
      errors.add(:user_email, :invalid, message: 'уже используется другим пользователем')
      false
    end
  end

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end
end
