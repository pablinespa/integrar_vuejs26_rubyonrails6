class Week < ApplicationRecord
  has_many :days, :dependent => :destroy

  belongs_to :service

  scope :number_week_asc, -> { order(number_week: :asc) }
end