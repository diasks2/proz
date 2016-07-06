require 'httparty'

module Proz
  class WiwoEntry
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
      self.class.post("/workstatus",
        body: body,
        headers: { 'Authorization' => "Bearer #{token}" } )
    end
  end
end
