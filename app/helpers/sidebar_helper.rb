# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-
module SidebarHelper

  # Returns the css class of a particular item in sidebar
  # It checks if the current controller or action is being executed and returns "active" if matches
  def sidebar_get_class(controller, action = nil)

    klass = "list-group-item"
    if controller_name == controller and action.nil?
      klass += " active"
    elsif controller_name == controller and action.is_a?(Array) and action.include?(action_name)
      klass += " active"
    elsif controller_name ==controller and action_name == action
      klass += " active"
    end
    klass
  end
end
