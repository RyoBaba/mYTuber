class ChannelsController < ApplicationController
  include External::YouTube
  def show
    @channel = Channel.find_by(id: params[:id])
    youtube_go
    hoge = Hoge.new
    hoge.hoge_method
    hoge.base_method
  end
end
