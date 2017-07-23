module ChannelInfo extend ActiveSupport::Concern
  def published_ym
    Video.where(channel_id: @channel.id)
      .pluck("year(published_at) as y", "month(published_at) as m").uniq.sort
  end
end