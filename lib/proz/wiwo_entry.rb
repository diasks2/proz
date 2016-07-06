require 'httparty'

module Proz
  class WiwoEntry
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token
    def initialize(token:)
      @token = token
    end

    def post
      self.class.post("/workstatus",
        body: { message: 'This is a test from TMT',
                source_language: "eng",
                target_language: "spa",
                wordcount: "234" }.to_json,
        headers: { 'Authorization' => "Bearer #{token}" } )
    end
  end
end