class Grunt < ActiveRecord::Base

  belongs_to :yak

  has_many :herd_grunts, :dependent => :destroy
  has_many :herds, :through => :herd_grunts

  # after_save :attach_or_create_herd

  def self.nearest_grunt(lat, long, mile_radius = 5)
    Grunt.find_by_sql("
      SELECT id, geo_lat, geo_long, created_at,
      ( 3959 * acos( cos( radians( #{lat} ) ) * cos( radians( geo_lat ) ) * cos( radians( geo_long ) - radians( #{long} ) ) + sin( radians( #{lat} ) ) * sin( radians( geo_lat ) ) ) ) AS distance
      FROM grunts HAVING distance < #{mile_radius} ORDER BY distance LIMIT 1
    ")
  end

private

  def attach_or_create_herd
    nearest_grunt = Grunt.nearest_grunt(geo_lat, geo_long)
    if nearest_grunt
      nearest_grunt.herd.grunts << self
    else
      Herd.create(geo_lat: geo_lat, geo_long: geo_long).grunts << self
    end
  end

end
