class Grunt < ActiveRecord::Base

  belongs_to :yak
  belongs_to :herd

  after_create :notify_herd

  private

  def notify_herd
    if herd
      ActiveSupport::Notifications.instrument("herd#{herd.id}", extra: :information) do

      end
    end
  end

end
