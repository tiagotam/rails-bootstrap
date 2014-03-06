# Rails Bootstrap
# @author Tiago <tiago@tamworks.com>
# -*- coding: utf-8 -*-

class Company < ActiveRecord::Base

  #-------------------
  # Extentions
  #-------------------
  extend FriendlyId
  friendly_id :uuid


  #-------------------
  # Associations
  #-------------------
  has_many :users, dependent: :destroy

  #-------------------
  # Validations
  #-------------------
  validates :name, presence: true, allow_blank: false


  #-------------------
  # Callbacks
  #-------------------
  before_create :set_fields


  #-------------------
  # Public Methods
  #-------------------


  #-------------------
  # Private Methods
  #-------------------

  private

  def set_fields
    self.uuid = SecureRandom.uuid
  end

end
