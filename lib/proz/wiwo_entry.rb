require 'httparty'

module Proz
  class WiwoEntry
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token, :message
    def initialize(token:, message:)
      @token = token
      @message = message
    end

    def post
      self.class.post("/workstatus",
        body: { message: message,
                source_language: "eng",
                target_language: "spa",
                wordcount: "234" },
        headers: { 'Authorization' => "Bearer #{token}" } )
    end
  end
end