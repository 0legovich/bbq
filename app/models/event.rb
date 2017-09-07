class Event < ActiveRecord::Base
  validate :title, :adress, :datetime, presence: true
  validate :title, length: { maximum: 255 }
end
