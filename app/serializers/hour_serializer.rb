class HourSerializer < ApiSerializer

  attributes :id, :bol_available, :range_hour, :users

  def hour_start
    format_time(object.hour_start)
  end

  def hour_end
    format_time(object.hour_end)
  end

  def users
    # ActiveModelSerializers::SerializableResource.new(self.object.users.where("user_availabilities.available=?", false),
    #                                                  each_serializer: UserLittleSerializer,
    #                                                  scope: {hour_id: object.id})

    ActiveModelSerializers::SerializableResource.new(self.object.users,
                                                     each_serializer: UserLittleSerializer,
                                                     scope: {hour_id: object.id})
  end

  def bol_available
    UserAvailability.where(hour_id: object.id).where(available: true).count==0
  end
end
