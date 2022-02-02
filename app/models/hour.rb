class Hour < ApplicationRecord
  has_many :user_availabilities, :class_name => "UserAvailability", foreign_key: :hour_id, dependent: :destroy
  has_many :users, :through => :user_availabilities, source: :user

  belongs_to :day
  belongs_to :service

  scope :hour_start_asc, -> { order(hour_start: :asc) }
end