class ChannelsController < ApplicationController
  include External::YouTube
  before_action :set_channel_data, only: %w(show)
  def show
    @apidata = @channel.import_channel_info
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
  end
end
