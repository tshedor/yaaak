class Grunt < ActiveRecord::Base
  belongs_to :yak
  belongs_to :herd

  after_create :notify_herd

  private

  def notify_herd
  	logger.debug 'HEHEHEHEHEHEHEHE'
  	logger.debug self
    herd.notify_herd(self)
  end


end
