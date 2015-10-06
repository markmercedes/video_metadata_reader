class VideoInfoController < ApplicationController

  def metadata
    video_meta = Rails.cache.fetch("/video/#{video_path}", :expires_in => nil) { FFMPEG::Movie.new(video_path) }
    respond_to do |format|
      format.json { render json: video_meta }
    end
  end

  private

  def video_path
    params[:path]
  end
end
