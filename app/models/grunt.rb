class Grunt < ActiveRecord::Base

  belongs_to :yak

  has_many :herd_grunts, :dependent => :destroy
  has_many :herds, :through => :herd_grunts

  profanity_filter! :message, :method => 'dictionary'

  has_attached_file :photo, :styles => { :thumbnail => '150x150>', :medium => '550x550>' }

  validates_attachment :photo,
  :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
  :size => { :in => 0..4000.kilobytes }

  after_save :attach_or_create_herd
  after_destroy :last_yak_grunt_check

  #self.default_scope { order('created_at DESC') }

  def display_name
    if yak && yak.name
      yak.name.split(' ')[1] ? yak.name.split(' ')[0][0] + yak.name.split(' ')[1][0] : yak.name.split(' ')[0][0]
    else
      'Unknown'
    end
  end

  def master_herd
    herds.first.master_herd if herds.any?
  end

  #find all grunts within a 5 mile radius and grunt to all of them? no master herd?

  #all grunts within a 5 mile radius - and all the herds associated with those grunts

  #when there are multiple herds make sure they are connected

  def connect_nearby_herds

  end

  def nearby_herds
    self.all_near_grunts.collect { |grunt| grunt.herds }.flatten.uniq
  end

  def all_near_grunts(mile_radius = 5)
    Grunt.find_by_sql("
      SELECT id, geo_lat, geo_long, created_at,
      ( 3959 * acos( cos( radians( #{geo_lat} ) ) * cos( radians( geo_lat ) ) * cos( radians( geo_long ) - radians( #{geo_long} ) ) + sin( radians( #{geo_lat} ) ) * sin( radians( geo_lat ) ) ) ) AS distance
      FROM grunts HAVING distance < #{mile_radius} AND id <> #{id} ORDER BY distance
    ")
  end

  def nearest_grunt(lat, long, mile_radius = 5)
    Grunt.find_by_sql("
      SELECT id, geo_lat, geo_long, created_at,
      ( 3959 * acos( cos( radians( #{lat} ) ) * cos( radians( geo_lat ) ) * cos( radians( geo_long ) - radians( #{long} ) ) + sin( radians( #{lat} ) ) * sin( radians( geo_lat ) ) ) ) AS distance
      FROM grunts HAVING distance < #{mile_radius} AND id <> #{id} ORDER BY distance LIMIT 1
    ").first
  end

  def self.delete_old_grunts
    Grunt.where('grunts.created_at < ?', Time.zone.now - 1.day).destroy_all
  end

private

  def attach_or_create_herd
    nearest_grunt = nearest_grunt(geo_lat, geo_long)
    if nearest_grunt && nearest_grunt.master_herd
      herd = nearest_grunt.master_herd
    else
      herd = Herd.create(geo_lat: geo_lat, geo_long: geo_long)
    end
    # herd.attach_yak(self)
    herd.grunts << self
    yak.update_attributes(herd_id: herd.id, geo_lat: geo_lat, geo_long: geo_long) if yak
  end

  def last_yak_grunt_check
    if yak.grunts.empty?
      yak.destroy
    end
  end

end
