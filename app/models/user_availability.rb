class UserAvailability < ApplicationRecord
  belongs_to :user, :class_name => "User", foreign_key: :user_id
  belongs_to :hour, :class_name => "Hour", foreign_key: :hour_id

  scope :available, -> {where("user_availabilities.available=?", true)}
  scope :not_available, -> {where("user_availabilities.available=?", false)}
end
