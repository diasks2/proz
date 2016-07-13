require 'httparty'

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

    def user_entries(user_uuid)
      self.class.get("/wiwo?user_uuid=" + user_uuid, headers: { 'X-Proz-API-Key' => key })
    end

    private

    def all_wiwos
      @wiwos ||= self.class.get("/wiwo", headers: { 'X-Proz-API-Key' => key })
    end
  end
end
