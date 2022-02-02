class UserLittleSerializer < ApiSerializer

  attributes :id,:first_name,:last_name,:color,:available, :qty_hours

  def available
    Rails.logger.info "*******hour_id******#{instance_options[:scope]}"
    unless instance_options[:scope].blank?
      unless instance_options[:scope][:hour_id].nil?
        object.get_hour_available(instance_options[:scope][:hour_id])
      end
    end
  end

  def qty_hours
    Rails.logger.info "*******hour_id******#{instance_options[:scope]}"
    unless instance_options[:scope].blank?
      unless instance_options[:scope][:day_id].nil?
        object.get_qty_hours(instance_options[:scope][:day_id])
      end
    end
  end
end
