module YouTubeHelper
  def video_url(youtube_video_id)
    "https://www.youtube.com/watch?v=#{youtube_video_id}"
  end
end