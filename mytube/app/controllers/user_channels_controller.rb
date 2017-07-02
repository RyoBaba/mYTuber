class UserChannelsController < ApplicationController
  def list
    
    @user_channels = current_user.user_channels.all.order("id")
    @channels = []
    @user_channels.each do |uc| 
      @channels.push Channel.find(uc.channel_id)
    end
    @videos = Importer::Videos.import @channels
  end
end
