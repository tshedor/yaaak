require 'serverside/sse'

class HerdsController < ApplicationController

  before_action :set_herd, only: [:show, :edit, :update, :destroy]

  include ActionController::Live

  def index
  	@herds = Herd.all
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    sse = ServerSide::SSE.new(response.stream)
    herd.notify_herd do |grunt|
      logger.debug 'ENTERING STREAM'
      sse.write({:message => grunt })
    end
    rescue IOError
    ensure
      sse.close
  end

  def show
    response.headers['Content-Type'] = 'text/event-stream'
    sse = ServerSide::SSE.new(response.stream)

    #@herd.notify_herd do |grunt|
    #  logger.debug 'ENTERING STREAM'
    #  sse.write({:message => grunt })
    #end

    ActiveSupport::Notifications.subscribe("herd#{@herd.id}") do |name, start, finish, id, payload|
      sse.write({:message => name })
    end

    rescue IOError
    ensure
      sse.close
  end

  def new
    @herd = Herd.new
  end

  def edit
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

  def update
    respond_to do |format|
      if @herd.update(herd_params)
        format.html { redirect_to @herd, notice: 'Herd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
end
