namespace :create_datas do
  task :service => :environment do
    include CmsHelper

    begin
      # create users
      User.create(email: 'benjamin@admin.com',
                  password: 'benjamin@123',
                  user_role: 'user',
                  first_name: 'Benjamin',
                  last_name: 'Test',
                  color: 'skyblue')

      User.create(email: 'barbara@admin.com',
                  password: 'benjamin@123',
                  user_role: 'user',
                  first_name: 'Barbara',
                  last_name: 'Test',
                  color: 'mediumpurple')

      User.create(email: 'test@admin.com',
                  password: 'benjamin@123',
                  user_role: 'user',
                  first_name: 'Ernest',
                  last_name: 'Test',
                  color: 'orange')
      # create service

      service = Service.new(name: "Monitoreo Recorrido.cl",
                           hour_range: 1,
                           monday_hour_start: 19,
                           monday_hour_end: 24,
                           tuesday_hour_start: 19,
                           tuesday_hour_end: 24,
                           wednesday_hour_start: 19,
                           wednesday_hour_end: 24,
                           thursday_hour_start: 19,
                           thursday_hour_end: 24,
                           friday_hour_start: 19,
                           friday_hour_end: 24,
                           saturday_hour_start: 10,
                           saturday_hour_end: 24,
                           sunday_hour_start: 10,
                           sunday_hour_end: 24)
      service.save

      # create user services
      User.not_admin.each do |user|
        user_service = UserService.new(user_id: user.id,
                                       service_id: service.id)
        user_service.save
      end

      # create hours
      hour_range = service.hour_range

      (1..get_week_num_year).each do |week_num|

        week = Week.new(service_id: service.id,
                        name_week: "Semana #{week_num} del #{Time.now.year}",
                        number_week: week_num,
                        year: Time.now.year)

        week.save

        range_days = get_range_days(week_num)

        week.update(range_days: "#{range_days[0]} al #{range_days[range_days.length-1]}")

        range_days.each do |array_day|

          day = array_day.to_datetime.strftime("%A")
          date_day = array_day.to_datetime.strftime("%d")
          date_month = array_day.to_datetime.strftime("%B")

          day_ = Day.new(week_id: week.id,
                         number_week:week.number_week,
                         name_day: "#{day} #{date_day} de #{date_month}",
                         date: array_day.to_date)

          day_.save

          case day
          when "Monday"
            day_hour_start = service.monday_hour_start
            day_hour_end = service.monday_hour_end
          when "Tuesday"
            day_hour_start = service.tuesday_hour_start
            day_hour_end = service.tuesday_hour_end
          when "Wednesday"
            day_hour_start = service.wednesday_hour_start
            day_hour_end = service.wednesday_hour_end
          when "Thursday"
            day_hour_start = service.thursday_hour_start
            day_hour_end = service.thursday_hour_end
          when "Friday"
            day_hour_start = service.friday_hour_start
            day_hour_end = service.friday_hour_end
          when "Saturday"
            day_hour_start = service.saturday_hour_start
            day_hour_end = service.saturday_hour_end
          when "Sunday"
            day_hour_start = service.sunday_hour_start
            day_hour_end = service.sunday_hour_end
          else

          end

          (day_hour_start.to_i..day_hour_end.to_i-1).each do |hour|
            h_start = hour.to_s + ":00"
            h_end = (h_start.to_time + hour_range.to_i.hour).strftime("%H:%M")

            puts "****h_start******#{h_start}"
            puts "****h_end******#{h_end}"

            h = Hour.new(service_id: service.id, day_id: day_.id, range_hour: "#{h_start}-#{h_end}", name_day: day, hour_start: h_start, hour_end: h_end)
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
      puts "****error******#{error.to_s}"
    end
  end

end