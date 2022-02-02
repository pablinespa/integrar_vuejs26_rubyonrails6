class AdminController < ActionController::Base

  protect_from_forgery

  def initialize
    super
    @ADMIN_PARTIALS_URL = '/admin/partials/'
  end
end
