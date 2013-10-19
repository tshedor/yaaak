class GruntsController < ApplicationController

  def index
  end
  def create
    @grunt = Grunt.new(grunt_params)

    respond_to do |format|
      if @grunt.save
        format.html { redirect_to @grunt, notice: 'Grunt was successfully created.' }
        format.json { render action: 'show', status: :created, location: @grunt }
      else
        format.html { render action: 'new' }
        format.json { render json: @grunt.errors, status: :unprocessable_entity }
      end
    end
  end

end
