require 'httparty'

module Proz
  class GetWiwoEntry
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token, :user_uuid, :include_private
    def initialize(token:, user_uuid:, include_private:)
      @token = token
      @include_private = include_private
      @user_uuid = user_uuid
    end

    def get
      if include_private
        self.class.get("/wiwo?user_uuid=" + user_uuid + "?include_private=1",
        headers: { 'Authorization' => "Bearer #{token}" } )
      else
        self.class.get("/wiwo?user_uuid=" + user_uuid,
        headers: { 'Authorization' => "Bearer #{token}" } )
      end
    end
  end
end
