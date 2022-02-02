class Service < ApplicationRecord
  has_many :user_services, :class_name => "UserService", foreign_key: :service_id, dependent: :destroy
  has_many :users, :through => :user_services, source: :user

  has_many :weeks, :dependent => :destroy
  has_many :hours, :dependent => :destroy

  validates_presence_of :name

  scope :search, ->(text) { where("lower(name) like :text ", {text: "%#{text.downcase}%"}) }
  scope :name_asc, -> { order(name: :asc) }
  scope :created_desc, -> { order(created_at: :desc) }


  def get_hour(day, type)
    hour = ""
    case day
    when "Monday"
    hour = (type=="start" ? self.monday_hour_start : self.monday_hour_end)
    when "Tuesday"
      hour = (type=="start" ? self.tuesday_hour_start : self.tuesday_hour_end)
    when "Wednesday"
      hour = (type=="start" ? self.wednesday_hour_start : self.wednesday_hour_end)
    when "Thursday"
      hour = (type=="start" ? self.thursday_hour_start : self.thursday_hour_end)
    when "Friday"
      hour = (type=="start" ? self.friday_hour_start : self.friday_hour_end)
    when "Saturday"
      hour = (type=="start" ? self.saturday_hour_start : self.saturday_hour_end)
    when "Sunday"
      hour = (type=="start" ? self.sunday_hour_start : self.sunday_hour_end)
    else

    end
    hour
  end

  # create / update days hours
  def create_update_days(days)
    days.each do |day|

      case day[0]
      when "Monday"
        self.update(monday_hour_start: day[1]["day_hour_start"],
                       monday_hour_end: day[1]["day_hour_end"])
      when "Tuesday"
        self.update(tuesday_hour_start: day[1]["day_hour_start"],
                       tuesday_hour_end: day[1]["day_hour_end"])
      when "Wednesday"
        self.update(wednesday_hour_start: day[1]["day_hour_start"],
                       wednesday_hour_end: day[1]["day_hour_end"])
      when "Thursday"
        self.update(thursday_hour_start: day[1]["day_hour_start"],
                       thursday_hour_end: day[1]["day_hour_end"])
      when "Friday"
        self.update(friday_hour_start: day[1]["day_hour_start"],
                       friday_hour_end: day[1]["day_hour_end"])
      when "Saturday"
        self.update(saturday_hour_start: day[1]["day_hour_start"],
                       saturday_hour_end: day[1]["day_hour_end"])
      when "Sunday"
        self.update(sunday_hour_start: day[1]["day_hour_start"],
                       sunday_hour_end: day[1]["day_hour_end"])
      else

      end
    end
  end

  # create user services
  def create_user(user_ids, type="create")
    if type != "create"
      self.user_services.destroy_all
    end
    user_ids.each do |user_id|
      UserService.create(service_id: self.id, user_id: user_id)
    end
  end

  # generate schedule
  def generate_schedule(days, hour_range)
    begin

      (1..get_week_num_year).each do |week_num|

        week = Week.new(service_id: self.id,
                        name_week: "Semana #{week_num} del #{Time.now.year}",
                        number_week: week_num,
                        year: Time.now.year)

        week.save

        range_days = get_range_days(week_num)

        range_days.each do |array_day|

          day = array_day.to_datetime.strftime("%A")
          date_day = array_day.to_datetime.strftime("%d")
          date_month = array_day.to_datetime.strftime("%B")

          day_ = Day.new(week_id: week.id,
                         number_week: week.number_week,
                         name_day: "#{day} #{date_day} de #{date_month}",
                         date: array_day.to_date)

          day_.save

          range_hours = days["#{day}"]

          (range_hours["day_hour_start"].to_i..range_hours["day_hour_end"].to_i-1).each do |hour|
            h_start = hour.to_s + ":00"
            h_end = (h_start.to_time + hour_range.to_i.hour).strftime("%H:%M")

            h = Hour.new(service_id: self.id, day_id: day_.id, range_hour: "#{h_start}-#{h_end}", name_day: day, hour_start: h_start, hour_end: h_end)
            h.save

            # create user availabilities
            User.not_admin.each do |user|
              user_available = UserAvailability.new(user_id: user.id,
                                                    hour_id: h.id,
                                                    available: false)
              user_available.save
            end
          end

        end
      end

    rescue => error
      Rails.logger.info "****error******#{error.to_s}"
    end

  end

  # generate schedule
  def update_generate_schedule(days, hour_range)
    begin
      Rails.logger.info "******days******#{days}"
      Rails.logger.info "******days******#{days["Monday"]}"

      day_ids = Day.where(week_id: self.weeks.pluck("weeks.id")).pluck("days.id")

      day_ids.each do |day_id|
        day = Day.find_by(id: day_id)
        name_day = day.date.strftime("%A")
        #generate_hours(day.hours, days)
        Rails.logger.info "******name_day******#{days["#{name_day}"]}"

        range_hours = days["#{name_day}"]

        (range_hours["day_hour_start"].to_i..range_hours["day_hour_end"].to_i-1).each do |hour|
          h_start = hour.to_s + ":00"
          h_end = (h_start.to_time + hour_range.to_i.hour).strftime("%H:%M")

          h = Hour.new(service_id: self.id, day_id: day.id, name_day: name_day, hour_start: h_start.to_time, hour_end: h_end.to_time)
          h.save
        end
      end

    rescue => error
      Rails.logger.info "****error******#{error.to_s}"
    end

  end
end