class HerdGrunt < ActiveRecord::Base

  belongs_to :grunt
  belongs_to :herd

  after_create :notify_herd
  after_destroy :last_grunt_check

private

  def notify_herd
    if herd
      un = grunt.yak.name.split(' ')
      moniker = un[1] ? un[0][0] + un[1][0] : un[0][0]
      payload = {
          message: grunt.message,
          user_id: grunt.yak.id,
          user_name: moniker,
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
