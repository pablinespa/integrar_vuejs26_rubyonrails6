class ApiSerializer < ActiveModel::Serializer
  include CmsHelper
  include ActionView::Helpers::NumberHelper
  include Rails.application.routes.url_helpers
end
