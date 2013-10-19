class Grunt < ActiveRecord::Base
  belongs_to :yak
  belongs_to :herd

  after_create :notify_herd

  private

  def notify_herd
  	if herd
    	herd.notify_herd(self)
    else
    	logger.info 'Herd Not Found'
    end
  end


end
