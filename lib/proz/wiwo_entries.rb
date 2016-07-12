require 'httparty'

module Proz
  class WiwoEntries
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :api_key
    def initialize(api_key:)
      @api_key = api_key
    end

    def entries
      self.class.get("/wiwo", headers: { 'X-Proz-API-Key' => api_key })
    end

    def wiwo_entries
      self.class.get("/wiwo", headers: { 'X-Proz-API-Key' => api_key }).entries["wiwos"]
    end

    def user_entries
      self.class.get("/wiwo", headers: { 'X-Proz-API-Key' => api_key }).entries["users"]
    end

    def user_entries(user_uuid)
      self.class.get("/wiwo?user_uuid=" + user_uuid, headers: { 'X-Proz-API-Key' => api_key })
    end
  end
end
