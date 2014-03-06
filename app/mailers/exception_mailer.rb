# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>

class ExceptionMailer < ActionMailer::Base
  helper ApplicationHelper

  default from: 'Rails Bootstrap <hello@yourdomain.com>'

  layout 'email'

  def notify_exception(exception_log, ruby_exception)
    @exception_log = exception_log
    @ruby_exception = ruby_exception
    mail(:to => 'fireman@yourdomain.com', :subject => I18n.t('subject.error'))
  end

end