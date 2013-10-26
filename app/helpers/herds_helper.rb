module HerdsHelper
	def yak_in_herd
		if current_yak.herd.id == @herd.id
			"true"
		else
			"false"
		end
	end
end
