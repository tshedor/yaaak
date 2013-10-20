class Herd < ActiveRecord::Base

  require 'geo_ruby'

  has_many :grunts

  has_many :herd_grunts, :dependent => :destroy
  has_many :grunts, :through => :herd_grunts

  def self.test_point
    point = GeoRuby::SimpleFeatures::Point.new
    point.set_x_y(5, 5)
  end

end
