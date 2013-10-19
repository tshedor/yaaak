class Yak < ActiveRecord::Base

  belongs_to :herd
  has_many :grunts

end
