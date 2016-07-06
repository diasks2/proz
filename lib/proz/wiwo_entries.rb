require 'httparty'

module Proz
  class WiwoEntries
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token
    def initialize(token:)
      @token = token
    end

    def entries
      self.class.get("/workstatus", headers: { 'Authorization' => "Bearer #{token}" })
    end

    def user_entries(user_uuid)
      self.class.get("/workstatus?user_uuid=" + user_uuid, headers: { 'Authorization' => "Bearer #{token}" })
    end
  end
end
