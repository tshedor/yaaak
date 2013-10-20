require 'serverside/sse'

class HerdsController < ApplicationController

  before_action :set_herd, only: [:show, :destroy, :stream]
  after_action :set_session, only: [:show]

  include ActionController::Live

  def index
  	@herds = Herd.all
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    sse = ServerSide::SSE.new(response.stream)
    begin
      ActiveSupport::Notifications.subscribe("herd#{@herd.id}") do |name, start, finish, id, payload|
        unless response.stream.closed?
          sse.write({message: 'testEvent', data: payload })
        end
      end
      loop do
        sleep 1
      end
    rescue
    ensure
      sse.close
      ActiveSupport::Notifications.unsubscribe("herd#{@herd.id}")
    end
  end

  def show
  	@grunt = Grunt.new
  end

  def new
    @herd = Herd.new
  end

  def create
    @herd = Herd.new(herd_params)

    respond_to do |format|
      if @herd.save
        format.html { redirect_to @herd, notice: 'Herd was successfully created.' }
        format.json { render action: 'show', status: :created, location: @herd }
      else
        format.html { render action: 'new' }
        format.json { render json: @herd.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @herd.destroy
    respond_to do |format|
      format.html { redirect_to herds_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_herd
      @herd = Herd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def herd_params
      params.require(:herd).permit(:message)
    end
    def set_session
      session.delete(:active_yak)
      logger.debug session.has_key?("active_yak")
      if session.has_key?("active_yak")
        ya = Yak.create(name: 'PANDA', color:'#ccc')
        logger.debug 'WWWWWW'
      	session[:active_yak] = ya.id
      else
      	logger.debug 'AAAAAAAAA'
      	session[:active_yak] = 12
      	logger.debug session[:active_yak]
      	logger.debug 'BLUEUEEEEE'
      end
    end
end
