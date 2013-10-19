class Herd < ActiveRecord::Base

  has_many :grunts
  has_many :yaks

end
