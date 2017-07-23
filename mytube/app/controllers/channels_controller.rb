class ChannelsController < ApplicationController
  include External::YouTube
  include ChannelInfo
  before_action :set_channel_data, only: %w(show back_number)

  # 指定されたチャンネルで公開されているビデオの一覧を時系列で表示
  # @param :id  channel_id
  # @param :year 公開年(published_at)
  # @param :month 公開月(published_at)
  # @param :page ページ番号 by kaminari
  def back_number
    # year,monthは任意
    conditions = ["year(published_at)='#{params[:year]}'"]
    conditions.push("month(published_at)='#{params[:month]}'") if params[:month].present?
    @videos = @channel.videos.where(conditions.join(' AND '))
      .order(:published_at)
      .page(params[:page])
  end

  def show
    @videos = @channel.videos.page(params[:page]).per(1)
  end

  def new
    @channel = Channel.new
  end

  def create
    channel = params[:channel]
    Channel.create(:name => channel[:name], :c_id => channel[:c_id])

    redirect_to '/'
  end

  private

  def set_channel_data
    @channel = Channel.find(params[:id])
    @yyyymm = published_ym
  end
end
