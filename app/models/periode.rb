class Periode < ActiveRecord::Base
  belongs_to :cursu
  belongs_to :classe
  has_many :cours
  validates_presence_of :nom

end
