class Cursu < ActiveRecord::Base
  has_many :periodes
  validates_presence_of :nom
end
