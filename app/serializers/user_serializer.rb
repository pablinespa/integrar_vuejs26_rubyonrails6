class UserSerializer < ApiSerializer

  attributes :access_token,
             :id,:qty_hours,:first_name,:last_name,:email, :color,
             :apple_id,:fb_id,:fb_token,:profile_picture

  def profile_picture
    self.object.profile_picture.nil? ? nil : root_url.to_s[0..-2] + self.object.profile_picture
  end

  def qty_hours
    unless instance_options[:scope].blank?
      unless instance_options[:scope][:number_week].nil?
        object.get_service_qty_hours(instance_options[:scope][:number_week])
      end
    end
  end

end
