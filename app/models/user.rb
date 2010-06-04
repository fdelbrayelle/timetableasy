class User < ActiveRecord::Base
  acts_as_authentic
  belongs_to :classe
  belongs_to :campu
  has_many :evenements
  has_many :roles
  validates_presence_of :username, :password, :password_confirmation, :nom, :prénom, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
end
