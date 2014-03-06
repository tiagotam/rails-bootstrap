# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

module BootstrapPageHelper

  # Add page title element
  def add_page_title(title)
    html = <<-HTML
    <h1 class="page-header">#{title}</h1>
    HTML
    html.html_safe
  end


end

