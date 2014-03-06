# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

module BootstrapFormHelper

  # Check if a specific field is not null
  def check_null?(model, field)
    not_null = false
    model.class.columns.each do |column|
      if column.name == field.to_s
        if column.null == false
          not_null = true
        end
        break
      end
    end
    not_null
  end

  # Create a text field
  def add_text_field(form, model, field, not_null=check_null?(model, field))
    html = <<-HTML
    <div class="form-group">
      #{form.label field, class: 'col-sm-3 control-label no-padding-right'}
      <div class="col-sm-9">
        #{form.text_field field, class: 'form-control'}
        #{not_null_field if not_null}
      </div>
    </div>
    HTML
    html.html_safe
  end

  # Create a password field
  def add_password_field(form, model, field, not_null=check_null?(model, field))
    html = <<-HTML
    <div class="form-group">
      #{form.label field, class: 'col-sm-3 control-label no-padding-right'}
      <div class="col-sm-9">
        #{form.password_field field, class: 'form-control'}
        #{not_null_field if not_null}
      </div>
    </div>
    HTML
    html.html_safe
  end

  # Create a checkbox for specific field
  def add_checkbox_field(form, model, field, text, checked=false)
    html = <<-HTML
      <div class="form-group">
        <div class="col-sm-3">&nbsp;</div>
        <div class="col-sm-9">
          <label>
            #{form.check_box(field, :checked => checked)}
            <span class="lbl"> #{text}</span>
          </label>
        </div>
      </div>
    HTML
    html.html_safe
  end

  # Create checkbox without form element
  def add_checkbox(text, id=nil)
    html = <<-HTML
      <div class="form-group">
        <div class="col-sm-3">&nbsp;</div>
        <div class="col-sm-9">
          <label>
            <input type="checkbox" id="#{id unless id.nil?}">
            <span class="lbl"> #{text}</span>
          </label>
        </div>
      </div>
    HTML
    html.html_safe
  end

  # Create label
  def add_label(text)
    html = <<-HTML
      <div class="form-group">
        <div class="col-sm-3">&nbsp;</div>
        <div class="col-sm-9">
          <label>
            <span class="lbl"> #{text}</span>
          </label>
        </div>
      </div>
    HTML
    html.html_safe
  end

  # Create submit button
  def add_submit_button(form, text=t('save'), extra_buttons=[])
    html = <<-HTML
      <div class="form-actions">
       #{form.submit text, :class => 'btn btn-flat btn-primary'}
    HTML
    html.html_safe
    extra_buttons.each do |btn|
      html += "&nbsp;&nbsp;"
      html += btn.html_safe
    end
    html += "</div>"
    html.html_safe
  end

  # Create submit and back button
  def add_submit_and_back_button(form, text=t('save'))
    add_submit_button(form, text, [back])
  end





end

