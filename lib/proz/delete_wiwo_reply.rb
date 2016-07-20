require 'httparty'

module Proz
  class DeleteWiwoReply
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token, :wiwo_id, :wiwo_reply_id
    def initialize(token:, wiwo_id:, wiwo_reply_id:)
      @token = token
      @wiwo_id = wiwo_id
      @wiwo_reply_id = wiwo_reply_id
    end

    def delete
      self.class.delete("/wiwo/#{wiwo_id}/replies/#{wiwo_reply_id}", headers: { 'Authorization' => "Bearer #{token}" } )
    end
  end
end