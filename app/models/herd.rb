class Herd < ActiveRecord::Base

  require 'geo_ruby'

  has_many :herd_grunts, :dependent => :destroy
  has_many :grunts, :through => :herd_grunts

  has_many :herds, foreign_key: 'parent_id'
  belongs_to :herd, foreign_key: 'parent_id'

  def yaks
    Yak.joins(:herd).where(herds: { id: id })
  end

  def furthest_grunt
    Grunt.find_by_sql("
      SELECT grunts.*,
      ( 3959 * acos( cos( radians( #{geo_lat} ) ) * cos( radians( geo_lat ) ) * cos( radians( geo_long ) - radians( #{geo_long} ) ) + sin( radians( #{geo_lat} ) ) * sin( radians( geo_lat ) ) ) ) AS distance
      FROM grunts
      INNER JOIN herd_grunts ON grunts.id = herd_grunts.grunt_id WHERE herd_grunts.herd_id = #{id}
      ORDER BY distance DESC LIMIT 1
    ").first
  end

  def herd_radius
    grunt_point = GeoRuby::SimpleFeatures::Point.from_lon_lat(furthest_grunt.geo_long, furthest_grunt.geo_lat)
    herd_point = GeoRuby::SimpleFeatures::Point.from_lon_lat(geo_long, geo_lat)
    (herd_point.euclidian_distance(grunt_point) * 80) + 5
  end

  def master_herd
    herd ? herd.master_herd : self
  end

end
