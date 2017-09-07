class User < ActiveRecord::Base
  has_many :events

  validates :name, :email, presence: true
  validates :email, format: /\A[a-zA-Z0-9_.\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+\z/,
    uniqueness: true, length: {maximum: 255}
  validates :name, length: {maximum: 35}
end
