class GruntController < ApplicationController

  include ActionController::Live

  def index
    20.times {
      response.stream.write "yakkity yak\n"
    }
    response.stream.close
  end

end
