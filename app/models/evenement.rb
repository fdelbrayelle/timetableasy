class Evenement < ActiveRecord::Base
  has_many :users
  has_many :campus
  has_many :classes
  has_many :espaces
  has_many :cours
  has_many :evaluations
  validates_presence_of :nom, :description, :duree
  validates_numericality_of :duree
end
