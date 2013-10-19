class Herd < ActiveRecord::Base
	has_many :yaks
	has_many :grunts

	def notify_herd(grunt)
	  grunt
	end
end
