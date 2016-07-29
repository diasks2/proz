require 'httparty'

module Proz
  class PostWiwoEntry
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token, :message, :options
    def initialize(token:, message:, **options)
      @token = token
      @message = { message: message }
      @options = options
    end

    def post
      body = message.merge!(options)
      self.class.post("/wiwo",
        body: body.to_json,
        headers: { 'Authorization' => "Bearer #{token}" } )
    end
  end
end
