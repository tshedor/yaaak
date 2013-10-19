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

    respond_to do |format|
      if !@grunt.save
        format.html { render action: 'new' }
        format.json { render json: @grunt.errors, status: :unprocessable_entity }
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
      params.require(:grunt).permit(:message, :herd_id, :yak_id)
    end
end
