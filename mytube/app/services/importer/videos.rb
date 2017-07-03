module Importer
  class Videos
    def self.import (channels)
      channels.each do |channel|
        recursive_import (channel)
      end
    end

    def self.recursive_import(channel)
      channel_updated = false
      option = {
        :youtube_channel_id => channel.youtube_channel_id,
      }
      option[:published_after] = to_date_for_api(channel.last_imported_at) unless channel.last_imported_at.nil?
      iteration(option).times do
        get(option)["items"].each do |v|
          Video.create({
            :channel_id => channel.id,
            :youtube_video_id => v["id"]["videoId"],
            :title => v["snippet"]["title"],
            :thumb_url => v["snippet"]["thumbnails"]["default"]["url"],
            :published_at => v["snippet"]["publishedAt"],
          })
          
          # 最初に取得したレコード（最新のビデオ）の公開日時をChannelにキャッシュ
          unless channel_updated
            channel.last_imported_at = v["snippet"]["publishedAt"]
            channel.save
            channel_updated = true
          end

          # items末尾（結果セットのうち最も古いレコード）の
          # 公開日時を次の問い合わせフィルタにセット
          option[:published_before] = to_date_for_api(v["snippet"]["publishedAt"])
        end
      end
    end

    def self.iteration (option)
      # APIの仕様上、１回のリクエストで取得できる結果セットの件数に上限（５０件）
      # 最小構成でAPIを叩き、結果セットから繰り返す回数を判定
      filter = build_filter(option)
      res = ExternalApi::YoutubeData.new.import( 'search', { 
        :part => "id",
        :filter => filter
      })
      return res["items"].empty? || res["pageInfo"]["resultsPerPage"].to_f.zero? ? 0 : ( res["pageInfo"]["totalResults"].to_f / res["pageInfo"]["resultsPerPage"].to_f ).ceil

    end

    def self.get( option )
      filter = build_filter(option)
      # ２回目以降のリクエストで追加するフィルタ
      filter[:publishedBefore] = option[:published_before] if option.has_key?(:published_before)
      ExternalApi::YoutubeData.new.import( 'search', { 
        :part => "id,snippet",
        :filter => filter
      })
    end

    def self.to_date_for_api d
      d.to_datetime.rfc3339
    end

    def self.build_filter option
      filter = {
        :order => "date",
        :channelId => option[:youtube_channel_id],
        :maxResults => 50,
        :type => "video",
      }
      # RFC3339形式に変換
      # https://developers.google.com/youtube/v3/docs/search/list?hl=ja
      filter[:publishedAfter] = option[:published_after] if option.has_key?(:published_after)
      return filter
    end

    private_class_method :recursive_import, :iteration, :get, :to_date_for_api, :build_filter
  end
end