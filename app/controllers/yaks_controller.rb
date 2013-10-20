class YaksController < ApplicationController
	def show
      @yak = Yak.find(params[:id])
    end
end
