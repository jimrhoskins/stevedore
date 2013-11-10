class ImagesController < ApplicationController
  def show
    @image = Image.find_by! uid: params[:uid]
  end
end
