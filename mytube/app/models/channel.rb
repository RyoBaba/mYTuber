class Channel < BaseYoutubeResource
  has_many :user_channels
  
  # youTube channel url
  def url
    "https://www.youtube.com/channel/#{self.youtube_channel_id}"
  end

  # YouTube data api
  def import_channel_info
    @data = ExternalApi::YoutubeData.new.import( Channel.resource_type, { 
      :part => "id,snippet,brandingSettings,contentDetails,invideoPromotion,statistics,topicDetails",
      :filter => { 'id' => self.c_id }
    })
  end

  attr_accessor :data
end
