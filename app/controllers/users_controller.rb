# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

class UsersController < ApplicationController
    
  before_filter :authenticate_user!

  # Action for create a new user
  def new
    @user = User.new
  end

  # Action for persist a new user
  def create
    @user = User.create(user_params_with_password)
    @user.company = current_user.company
    if @user.save
      flash[:success] = t('messages.default_success')
      redirect_to users_path
    else
      render :new
    end
  end

  # Action for edit a new user
  def edit
    if params[:id].present?
      @user = User.find_by_uuid(params[:id])
    else
      @user = current_user
    end
  end

  # Action for edit password of specific user passed by parameter
  def edit_password
    if params[:id].present?
      @user = User.find_by_uuid(params[:id])
    end
  end

  # Action for change and persist the new password
  # It will also notify the user, based on flag 'send_password' submitted by the user
  def update_password
    @user = User.find_by_uuid(params[:id])
    if @user.update(user_params_with_password)
      if @user.send_password.present? && @user.send_password.to_i == 1
        @user.send_welcome_email
      end
      flash[:success] = t('messages.default_success')
      redirect_to users_path
    else
      flash[:error] = t('messages.default_error')
      render :edit_password
    end
  end

  # Action for persist the changes in specific user
  def update
    @user = User.find_by_uuid(params[:id])
    if @user.update(user_params_without_password)
      flash[:success] = t('messages.default_success')
      redirect_to users_path
    else
      flash[:error] = t('messages.default_error')
      render :edit
    end
  end

  # Action for show user details
  def show
    if params[:id].present?
      @user = User.find_by_uuid(params[:id])
    else
      @user = current_user
    end
  end

  # Action for delete specific user
  def destroy
    @user = User.find_by_uuid(params[:id])
    if @user.destroy
      flash[:success] = t('messages.default_success')
    else
      flash[:error] = t('messages.default_error')
    end
    redirect_to users_path
  end

  # Action for list all users from current company
  def index
    params[:q] = {} if params[:q].blank?
    params[:q][:company_id_eq] = current_user.company_id
    @q = User.search(params[:q])
    @users = @q.result(:distinct => true).paginate(:page => params[:page])
  end

  private

  # Sanitize form parameters without password
  def user_params_without_password
    params.required(:user).permit(:first_name, :last_name, :email)
  end

  # Sanitize form parameters will all allowed fields for model user
  def user_params_with_password
    params.required(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :send_password)
  end
  
end