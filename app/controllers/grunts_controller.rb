require 'serverside/sse'

class GruntsController < ApplicationController
  include ActionController::Live

  def index
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    sse = ServerSide::SSE.new(response.stream)
    begin
        sse.write({ :message => "#{params[:message]}" })
    rescue IOError
    ensure
      sse.close
    end
  end
end
