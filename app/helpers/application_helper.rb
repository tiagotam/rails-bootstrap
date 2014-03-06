# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

module ApplicationHelper

  # Returns icon with 16x16 dimension
  def icon16(icon_name)
    "icons/16x16/#{icon_name}.png"
  end

  # Returns alert with message and type
  def bootstrap_alert(message, type)
    html = <<-HTML
      <div class="alert #{type}">
        <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
        #{message}
      </div>
    HTML
    html.html_safe
  end

  # Show errors of some resource
  def error_messages!(resource)
    return '' if resource.blank? or resource.errors.empty?
    message = "<strong>#{I18n.t('messages.cannot_proceed')}:</strong> <ul>"
    message += resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    message += "</ul>"
    html = bootstrap_alert(message, 'alert-danger')
    html.html_safe
  end

  # Generates a random id
  def random_id(suffix = '_ID')
    rand(36**8).to_s(36) + "_#{suffix}"
  end

  # Returns a image to inform the user that the field is required
  def not_null_field
    msg = "<div style='display:inline;'>"
    msg += image_tag(icon16('bullet_red'),
                     "data-toggle" => 'tooltip',
                     "data-placement" => 'right',
                      :title => I18n.t('required_field'),
                      :alt => I18n.t('required_field'),
                      :style => 'padding-left:4px;padding-top:4px')
    msg += "</div>"
    msg.html_safe
  end

  # Shows back button to specific page
  def back(url=nil)
    if url.present?
      link_to "<i class='icon-chevron-left icon-white'></i>".html_safe + t('back'), url, :class => 'btn btn-default'
    else
      msg = "<a href='#' onclick='history.go(-1);return false;' class='btn btn-default'><i class='icon-chevron-left icon-white'></i> #{t('back')}</a>"
      msg.html_safe
    end

  end


end
