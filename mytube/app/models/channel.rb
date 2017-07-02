class Channel < BaseYoutubeResource
  def import_channel_info
    @data = ExternalApi::YoutubeData.new.import( Channel.resource_type, { 
      :part => "id,snippet,brandingSettings,contentDetails,invideoPromotion,statistics,topicDetails",
      :filter => { 'id' => self.c_id }
    })
  end
  attr_accessor :data
end
