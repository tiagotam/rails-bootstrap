# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

class CompaniesController < ApplicationController

  before_filter :authenticate_user!

  # Action for edit current company
  def edit
    @company = Company.find_by_uuid(current_user.company.uuid)
  end

  # Action for update data for current company
  def update
    @company =  Company.find_by_uuid(current_user.company.uuid)
    if @company.update(company_params)
      flash[:success] = t('messages.default_success')
      redirect_to dashboard_url
    else
      flash[:error] = t('messages.default_error')
      render :edit
    end
  end

  private

  # Sanitize and keep only allowed fields
  def company_params
    params.required(:company).permit(:name)
  end

end