class Herd < ActiveRecord::Base

  require 'geo_ruby'

  has_many :grunts

  has_many :herd_grunts, :dependent => :destroy
  has_many :grunts, :through => :herd_grunts

  has_many :herds, foreign_key: 'parent_id'
  belongs_to :herd, foreign_key: 'parent_id'

  self.default_scope { order('created_at DESC') }

  def yaks
    Yak.joins(:herd).where(herds: { id: id })
  end

  def master_herd
    herd ? herd.master_herd : self
  end

  def self.test_point
    point = GeoRuby::SimpleFeatures::Point.new
    point.set_x_y(5, 5)
  end

end
