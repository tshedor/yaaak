class HerdGrunt < ActiveRecord::Base

  belongs_to :grunt
  belongs_to :herd

  after_create :notify_herd

  private

  def notify_herd
    if herd
      payload = {
          message: grunt.message,
          user_id: grunt.yak.id,
          user_name: grunt.yak.name,
          created_at: grunt.created_at
      }
      ActiveSupport::Notifications.instrument("herd#{herd.id}", payload)
    end
  end

end
