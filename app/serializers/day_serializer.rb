class DaySerializer < ApiSerializer

  attributes :id, :name_day, :range_days, :hours, :users

  # has_many :hours, serializer: HourSerializer, key: :hours

  def hours
    ActiveModelSerializers::SerializableResource.new(self.object.hours.hour_start_asc,
                                                     each_serializer: HourSerializer)
  end

  def users
    ActiveModelSerializers::SerializableResource.new(self.object.week.service.users,
                                                     each_serializer: UserLittleSerializer,
                                                     scope: {day_id: object.id})
  end

  def range_days
    object.week.range_days
  end

end
