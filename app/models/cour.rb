class Cour < ActiveRecord::Base
  belongs_to :periode
  belongs_to :evenement
  has_many :evaluations
  validates_presence_of :nom
  validates_numericality_of :heures_total, :greater_than => 0
  validates_numericality_of :heures_reste, :greater_than => 0
end
