class Campu < ActiveRecord::Base
  belongs_to :evenement
  has_one :user
  has_many :classes
  has_many :espaces
  validates_presence_of :nom, :pays
end
