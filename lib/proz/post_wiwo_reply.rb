require 'httparty'

module Proz
  class PostWiwoReply
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token, :id, :message, :options
    def initialize(token:, id:, message:, **options)
      @token = token
      @id = id
      @message = { message: message }
      @options = options
    end

    def post
      body = message.merge!(options)
      self.class.post("/wiwo/#{id}/replies",
        body: body,
        headers: { 'Authorization' => "Bearer #{token}" } )
    end
  end
end
