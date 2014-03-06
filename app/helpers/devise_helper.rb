# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

module DeviseHelper

  # This method is used by devise and returns the name of model used to authentication
  def resource_name
    :user
  end

  # Same thing here, if @resource doesn't exist, creates a new one
  def resource
    @resource ||= User.new
  end

  # Mapping the model used by devise
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


end
