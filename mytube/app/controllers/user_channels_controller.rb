class UserChannelsController < ApplicationController

  before_action :set_user_channels, only: %w(list)
  before_action :set_user_channel, only: %w(show refresh edit)

  # redirect to login user's channel
  def index
    redirect_to action: "list", user_id: current_user.id 
  end

  def list
  end

  def refresh
    @channel = @user_channel.channel
    Importer::Videos.import [@channel]
    count = Video.where(channel_id: @channel.id).count
    render json: {message: "success", count: count, user_channel_id: @user_channel.id }, :status => 200
  rescue => e
    render json: {message: e.message}, :status => 500
  end

  #### RESTful (resources) ####

  ## CREATE
  def new
    @user_channel = UserChannel.new
  end

  def create
    
    # チャンネルマスタに未登録なら登録しておく
    @channel = Channel.where(:youtube_channel_id => params[:youtube_channel_id]).first
    unless @channel.present?
      @channel = Channel.create({
        :name               => params[:name],
        :youtube_channel_id => params[:youtube_channel_id]
      })
    end
    @user_channel = UserChannel.create!({
      :user_id    => current_user.id,
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

  # get all user_channel's data
  # @param :user_id
  def set_user_channels
    @user_channels = UserChannel.where(user_id: params[:user_id]).order(:id)
  end

  def set_user_channel
    @user_channel = UserChannel.find(params[:id])
  end

end
