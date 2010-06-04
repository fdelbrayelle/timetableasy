class Espace < ActiveRecord::Base
  belongs_to :campu
  belongs_to :evenement
  validates_presence_of :code, :type
end
