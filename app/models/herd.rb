class Herd < ActiveRecord::Base

  has_many :grunts

  has_many :herd_grunts, :dependent => :destroy
  has_many :grunts, :through => :herd_grunts

  def herd_size
    # calculate the epicenter and then the furthest point away from the epicenter
    # then expand that circle to the desired radius
    grunts.each do |grunt|
      grunt.geo_lat
      grunt.geo_long
    end
  end

end
