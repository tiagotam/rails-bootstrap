# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

module DateHelper

  # Returns pattern for date based on current locale
  def day_month_year
    I18n.locale.to_s == 'pt' ? "%d/%m/%Y" : "%m/%d/%Y"
  end

  # Returns pattern fot date and time based on current locale
  def day_month_year_hour_minute
    I18n.locale.to_s == 'pt' ? "%d/%m/%Y %H:%M" : "%m/%d/%Y %I:%M %P"
  end

  # Apply pattern to a datetime variable
  def strftime(time, pattern)
    time.present? ? time.strftime(send pattern) : nil
  end

  # Formats datetime appropriately
  def format_date_time(date)
    strftime(date, :day_month_year_hour_minute)
  end

  # Formats date appropriately
  def format_date(date)
    strftime(date, :day_month_year)
  end

end