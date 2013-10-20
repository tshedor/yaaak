class Yak < ActiveRecord::Base

  belongs_to :herd
  has_many :grunts

  before_create :generate_name, :generate_color

  def remember_me!
    self.auth_hash = secure_hash("#{id}--#{Time.now.utc}")
    self.save
  end

private

  def generate_name
    self.name = ['Imperial Yak', 'Golden Yak', 'Wolly Yak', 'Water Buffalo', 'Mammoth Yak', 'Wild Yak', 'Blind Yak', 'Geriatric Yak', 'Helpless Yak', 'Curious Yak', 'Cat Yak', 'Nefarious Yak', 'Byah Yak', 'Bubbly Yak', 'Orca Yak', 'Grunting Yak', 'Patient Yak', 'Jumpin Yak', 'Squatting Yak'].sample
  end

  def generate_color
    self.color = ['#575501', '#0177A8', '#356B83', '#AC2434', '#7A101D', '#77508D', '#50888D', '#0B545A', '#79A271', '#577751', '#D8D589', '#A8A8A8', '#EEB679', '#CAA883'].sample
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
