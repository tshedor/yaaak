class AddAttachmentPhotoToGrunts < ActiveRecord::Migration
  def self.up
    change_table :grunts do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :grunts, :photo
  end
end
