require 'uri'
require 'net/http'
require 'json'
require 'active_support/core_ext'

module ExternalApi
  class YoutubeData

    ROOT_PATH = 'https://www.googleapis.com/youtube/v3/'

    def initialize
      @id = ENV['GOOGLE_ACCOUNT']
      @pass = ENV['MAILER_PASSWORD']
      @api_key = ENV['YOUTUBE_API_KEY']
    end


    def import ( resource_type, options = {} )
      # uri = ROOT_PATH + resource_type
      uri = URI( ROOT_PATH + resource_type )
      uri.query = build_api_params(options)
      uri.to_s
      uri = URI.parse(uri.to_s)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      res = https.start {
        https.get(uri.request_uri)
      }
      if res.code == '200'
        JSON.parse(res.body)
      else
        { code: res.code, body: res.body, uri: uri.to_s  }
      end
    end

    private

    def build_api_params (options = {} )
      param = {
        'key'   => @api_key, # API key
        'part'  => options[:part]
      }
      if options[:filter].present?
        options[:filter].each do |k,v|
          param[k] = v
        end
      end
      param.to_param
    end

  end
end