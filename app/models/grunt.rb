class Grunt < ActiveRecord::Base

  belongs_to :yak
  belongs_to :herd

  after_create :notify_herd

  private

  def notify_herd
    if herd
      payload = {
        message: message,
        user_id: yak.id,
        user_name: yak.name,
        created_at: created_at
      }
      ActiveSupport::Notifications.instrument("herd#{herd.id}", payload)
    end
  end

end
