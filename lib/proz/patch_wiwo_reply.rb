require 'httparty'

module Proz
  class PatchWiwoReply
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token, :wiwo_id, :wiwo_reply_id, :options
    def initialize(token:, wiwo_id:, wiwo_reply_id:, **options)
      @token = token
      @wiwo_id = wiwo_id
      @wiwo_reply_id = wiwo_reply_id
      @options = options
    end

    def patch
      self.class.patch("/wiwo/#{wiwo_id}/replies/#{wiwo_reply_id}",
        body: options,
        headers: { 'Authorization' => "Bearer #{token}" } )
    end
  end
end
