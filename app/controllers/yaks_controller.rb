class YaksController < ApplicationController

  def show
    @yak = Yak.find(params[:id])
  end

  def update
    @yak = Yak.find(params[:id])
    if @yak.update_attributes(name: params[:yak][:name])
      render status: 200
    else
      render status: 301
    end
  end

end
