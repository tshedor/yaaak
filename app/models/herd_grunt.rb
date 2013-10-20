class HerdGrunt < ActiveRecord::Base

  belongs_to :grunt
  belongs_to :herd

  after_create :notify_herd
  after_destroy :last_grunt_check

private

  def notify_herd
    if herd
      payload = {
          message: grunt.message,
          user_id: grunt.yak.id,
          user_name: grunt.yak.name,
          created_at: grunt.created_at,
          user_color: grunt.yak.color
      }
      ActiveSupport::Notifications.instrument("herd#{herd.id}", payload)
    end
  end

  def last_grunt_check
    if herd.grunts.empty? && herd.herds.empty?
      herd.delete
    end
  end

end
