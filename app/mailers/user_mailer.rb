# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>

class UserMailer < ActionMailer::Base

  helper ApplicationHelper

  helper Rails.application.routes.url_helpers

  default from: 'Rails Bootstrap <hello@yourdomain.com>'

  layout 'email'

  def welcome(user)
    @name = user.full_name
    @email = user.email
    @password = nil
    if user.send_password.present? and user.send_password.to_i == 1
      @password = user.password
    end
    mail(to: @email, subject: t('subject.welcome'))
  end

end