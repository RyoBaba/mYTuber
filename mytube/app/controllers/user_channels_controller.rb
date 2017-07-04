class UserChannelsController < ApplicationController

  before_action :set_user_channel, only: %w(index list)

  def index
  end

  def list
    @channels = []
    @user_channels.each do |uc| 
      @channels.push Channel.find(uc.channel_id)
    end
    @videos = Importer::Videos.import @channels
  end

  #### RESTful (resources) ####

  ## CREATE
  def new
    @user_channel = UserChannel.new
  end

  def create
    
    # チャンネルマスタに未登録なら登録しておく
    @channel = Channel.where(:youtube_channel_id => params[:youtube_channel_id])
    unless @channel.present?
      @channel = Channel.create({
        :name               => params[:name],
        :youtube_channel_id => params[:youtube_channel_id]
      })
    end

    binding.pry
    @user_channel = UserChannel.create({
      :channel_id => @channel.id
    })

  end

  ## READ
  def show
  end

  ## UPDATE
  def edit
  end

  def update
  end

  ## DELETE
  def destroy
  end

  private 

  def set_user_channel
    @user_channels = current_user.user_channels
  end

end
