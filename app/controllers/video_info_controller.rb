class VideoInfoController < ApplicationController

  def metadata
    respond_to do |format|
      format.json { render json: FFMPEG::Movie.new(video_path) }
    end
  end

  private

  def video_path
    params[:path]
  end
end
