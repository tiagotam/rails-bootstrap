# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter :update_sanitized_params, if: :devise_controller?

  # The last route in routes.rb should point to this action
  # It raises 404 error
  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  # Rescue from exception when in production environment
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :error_500
    rescue_from ActiveRecord::RecordNotFound, :with => :error_404
    rescue_from ActionController::RoutingError, :with => :error_404
  end

  # Ensure that devise will accept only this fields, during the registration
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u|
      u.permit(:first_name, :last_name, :company_name, :email, :password,
               :password_confirmation, :reset_password_token)
    }
  end

  # Handler for error 400 - Persists the exception, notify team and
  # shows a funny screen for the user
  def error_404(exception)
    exception_log = ExceptionLog.new(exception_attributes(exception))
    exception_log.user = current_user if current_user.present?
    exception_log.save
    ExceptionMailer.notify_exception(exception_log , exception).deliver
    render :template => 'errors/error_404', :layout => 'error', :status => 404
  end

  # Handler for error 500 - Persists the exception, notify team and
  # shows a funny screen for the user
  def error_500(exception)
    exception_log = ExceptionLog.new(exception_attributes(exception))
    exception_log.user = current_user if current_user.present?
    exception_log.save
    ExceptionMailer.notify_exception(exception_log , exception).deliver
    render :template => 'errors/error_500', :layout => 'error'
    true
  end

  # Returns current company of current user
  def current_company
    if current_user.present? && current_user.company.present?
      current_user.company
    else
      nil
    end
  end

  private

  # Prepares hash with exception information to persist
  def exception_attributes(exception)
    {:controller => params[:controller],
     :action => params[:action],
     :params => params.except('action', 'controller').inspect,
     :ip => request.remote_ip,
     :exception => exception.inspect
    }
  end

  # Method called after a new user successfully signed up
  def after_sign_up_path_for(resource)
    dashboard_path
  end

  # Method called after user successfully signed in
  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
