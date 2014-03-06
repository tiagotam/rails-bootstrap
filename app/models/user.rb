# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

class User < ActiveRecord::Base

  #-------------------
  # Extentions
  #-------------------
  extend FriendlyId
  friendly_id :uuid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #-------------------
  # Associations
  #-------------------
  belongs_to :company


  #-------------------
  # Accessors
  #-------------------
  attr_accessor :company_name
  attr_accessor :send_password

  #-------------------
  # Validations
  #-------------------
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :company_name, :presence => true, :if => :should_validate_company

  #-------------------
  # Scopes
  #-------------------
  default_scope {order(full_name: :asc)}

  #-------------------
  # Callbacks
  #-------------------
  before_create :set_fields
  before_save :update_full_name
  after_create :send_welcome_email


  #-------------------
  # Public Methods
  #-------------------


  def should_validate_company
    !self.persisted? and self.company.nil?
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end


  #-------------------
  # Private Methods
  #-------------------

  private

  def update_full_name
    self.full_name = "#{self.first_name} #{self.last_name}"
  end

  def set_fields
    self.uuid = SecureRandom.uuid
    if self.company_name.present? && self.company.nil?
      self.company = Company.create(:name => company_name)
    end
  end


end
