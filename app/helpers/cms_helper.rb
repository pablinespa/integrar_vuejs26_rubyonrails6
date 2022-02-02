module CmsHelper

  include ActionView::Helpers::NumberHelper

  def format_date date
    return date.strftime("%m-%d-%Y") if not date.blank?
  end
  def format_date_v1 date
    return date.strftime("%m/%d/%Y") unless date.blank?
  end
  def format_date_v2 date
    return date.strftime("%d/%m/%Y") if not date.blank?
  end
  def format_date_custom_month date
    return date.strftime("%B %d, %Y") unless date.blank?
  end
  # MM/dd/yyyy HH:mm
  def format_date_time_v2 datetime
    return datetime.strftime("%m/%d/%Y %H:%M") if not datetime.blank?
  end
  def format_date_time datetime
    return datetime.strftime("%m-%d-%Y %H:%M %p") if not datetime.blank?
  end
  def format_time datetime
    return datetime.strftime("%H:%M") if not datetime.blank?
  end

  def format_time_v1 datetime
    return datetime.strftime("%l:%M %p") unless datetime.blank?
  end
  def format_time_v2 datetime
    return datetime.strftime("%H:%M") if not datetime.blank?
  end

  def format_errors errors
    formatted_errors = {}
    errors.each do |key, error|
      formatted_errors[key] = (error.class == String) ? error : error.join(', ')
    end

    formatted_errors
  end

  def current_year
    Time.zone.now.strftime('%Y')
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    _class = 'table-column sorting'
    _class += column == sort_column.to_s ? "_#{direction.to_s}" : ''
    # icon = sort_direction == "asc" ? "fa fa-chevron-up" : "fa fa-chevron-down"
    # icon = column == sort_column ? icon : ""
    # link_to "#{title} <span class='#{icon}'></span>".html_safe, {sorting: column, order: direction}
    if table_columns.map{|x| x.to_s}.include? column
      link_to title.html_safe, {sorting: column, order: direction}, class: _class
    else
      title.to_s
    end
  end


  def current_class?(test_path)
    return "class=active" if request.path.include?(test_path)
    ''
  end

  # element to array
  # elements = ["elem1", "elem2"]
  def select_type(elements)

    if elements.count > 0
      types = []
      elements.each do |elem|
        types.push({ "name" => elem, "id" => elem })
      end
    else
      types = [{"name" => '', "id" => ""}]
    end
    data_for_select = types.each.map { |h| {h["name"] => h["id"]} }
    res = Hash[*data_for_select.map(&:to_a).flatten]

    res
  end

  # custom number currency
  def number_custom_currency(price, unit='$', precision=0)
    number_to_currency(price, locale: :en, precision: precision, unit: unit, delimiter: ".")
  end

  # generate random characters
  def random_character(length=5)
    (0..length).map{('a'..'z').to_a[rand(26)]}.join
  end

  # get number month to year
  def get_week_num_year(year = Time.now.year)
    days = Time.days_in_year(year)
    week_num = days/7
    week_num
  end

  # get range days by number week
  def get_range_days(year = Time.now.year, week_num)
    week_start = Date.commercial( year, week_num, 1 )
    week_end = Date.commercial( year, week_num, 7 )

    range_days = (week_start..week_end).to_a

    range_days
  end
end
