class GruntsController < ApplicationController
  before_action :set_herd, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  	@grunt = Grunt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grunt }
      format.js
    end
  end

  def create
    yak = current_or_create_yak(grunt_params[:geo_lat], grunt_params[:geo_long])
    @grunt = yak.grunts.new(grunt_params)
    if @grunt.message.presence && @grunt.geo_lat.presence && @grunt.save
      render json: { herd_id: @grunt.herds.first.id }
    else
    	if !@grunt.message.presence
    	  render json: { errors: @grunt.errors, status: :unprocessable_entity, grunt_error: 'message' }
    	elsif !@grunt.geo_lat.presence
    	  render json: { errors: @grunt.errors, status: :unprocessable_entity, grunt_error: 'geo' }
    	else
    	  render json: { errors: @grunt.errors, status: :unprocessable_entity, grunt_error: 'unknown' }
    	end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grunt
      @grunt = Grunt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grunt_params
      params.require(:grunt).permit(:message, :yak_id, :geo_lat, :geo_long, :photo)
    end
end
