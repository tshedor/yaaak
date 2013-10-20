class YaksController < ApplicationController

  def show
    @yak = Yak.find(params[:id])
  end

  def update
    @yak = Yak.find(params[:id])
    if @yak.update_attributes(name: params[:name])
      render json: @yak
    else
      render json: @yak.errors, status: :unprocessable_entity
    end
  end

end
