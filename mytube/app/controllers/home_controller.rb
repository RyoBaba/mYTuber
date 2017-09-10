class HomeController < ApplicationController
  def index
    # ランダムに動画を１件取得する
    @pickup_video = Video.offset( rand(Video.count) ).first
  end
end
