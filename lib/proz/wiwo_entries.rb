require 'httparty'
require 'uri'

module Proz
  class WiwoEntries
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :key
    def initialize(key:)
      @key = key
    end

    def entries
      all_wiwos
    end

    def wiwos
      all_wiwos["wiwos"]
    end

    def users
      all_wiwos["users"]
    end

    def filtered_entries(**options)
      if options[:user_uuid]
        user_uuid_query = "user_uuid=" + options[:user_uuid] + '&'
      else
        user_uuid_query = ""
      end
      if options[:keyword]
        keyword_query = "message_contains=" + URI.encode(options[:keyword], /\W/) + '&'
      else
        keyword_query = ""
      end
      if options[:min_time]
        min_time_query = "min_time=" + URI.encode(options[:min_time]) + '&'
      else
        min_time_query = ""
      end
      self.class.get("/wiwo?" + user_uuid_query + keyword_query + min_time_query, headers: { 'X-Proz-API-Key' => key })
    end

    private

    def all_wiwos
      @wiwos ||= self.class.get("/wiwo", headers: { 'X-Proz-API-Key' => key })
    end
  end
end
