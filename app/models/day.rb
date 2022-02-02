class Day < ApplicationRecord
  has_many :hours, :dependent => :destroy

  belongs_to :week

  scope :date_asc, -> { order(date: :asc) }
end