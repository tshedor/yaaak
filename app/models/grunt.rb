class Grunt < ActiveRecord::Base

  belongs_to :yak

  has_many :herd_grunts, :dependent => :destroy
  has_many :herds, :through => :herd_grunts

end
