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
    @grunt = Grunt.new(grunt_params)
    if @grunt.save
      render json: @grunt
    else
      render json: @grunt.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grunt
      @grunt = Grunt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grunt_params
      params.require(:grunt).permit(:message, :yak_id, :geo_lat, :geo_long)
    end
end
