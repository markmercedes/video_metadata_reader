require 'invalid_path'

class VideoInfoController < ApplicationController

  rescue_from InvalidPath, with: :invalid_path

  def metadata
    video_meta = Rails.cache.fetch("/video/#{video_path}", :expires_in => nil) do
      result = FFMPEG::Movie.new(video_path).as_json
      raise InvalidPath.new if result["duration"] == 0
      result
    end

    respond_to do |format|
      format.json { render json: video_meta }
    end
  end

  def invalid_path
    render json: { message: 'Invalid Path' }, status: 400
  end

  private

  def video_path
    params[:path]
  end
end
