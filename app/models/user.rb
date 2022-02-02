class User < ApplicationRecord
  enum user_roles: {user: 'user', admin: 'admin'}

  # Permit basic validation for easy edit user information
  @@normal_registration = true

  has_many :user_services, :class_name => "UserService", foreign_key: :user_id, dependent: :destroy
  has_many :services, :through => :user_services, source: :service

  has_many :user_availabilities, :class_name => "UserAvailability", foreign_key: :user_id, dependent: :destroy
  has_many :hours, :through => :user_availabilities, source: :hour

  has_secure_password validations: false

  validates_presence_of :password, if: :check_new_record?
  validates_presence_of :user_role, allow_blank: true

  validates :email, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ ,:allow_nil => true

  validates_uniqueness_of :email

  scope :not_admin, -> {where.not(user_role: user_roles[:admin])}
  scope :only_user, -> {where("user_role=?",'user')}
  scope :search, -> (text) {where("lower(full_name) like :text or lower(email) like :text", {text: "%#{text.downcase}%"})}
  scope :name_asc, -> { order(first_name: :asc) }

  before_destroy :delete_file_disk

  def delete_file_disk
    # delete picture
    delete_file(self.profile_picture) unless self.profile_picture.blank?
  end

  def fullname
    "#{self.first_name} #{self.last_name}"
  end

  def normal_registration bool
    @@normal_registration = bool
  end

  def get_hour_available(hour_id)
    UserAvailability.find_by(hour_id: hour_id,
                             user_id: self.id).available
  end

  def get_qty_hours(day_id)
    self.user_availabilities
        .available.where("user_availabilities.hour_id in (?)", Hour.where(day_id: day_id).pluck(:id))
        .count
  end

  def get_service_qty_hours(number_week)
    day_ids = Day.where(number_week: number_week).pluck(:id)
    hour_ids = Hour.where(day_id: day_ids).pluck(:id)

    self.user_availabilities
        .available.where("user_availabilities.hour_id in (?)", hour_ids)
        .count
  end

  private

  def check_new_record?
    self.new_record? && @@normal_registration
  end
end