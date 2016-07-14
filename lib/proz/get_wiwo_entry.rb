require 'httparty'

module Proz
  class GetWiwoEntry
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token, :include_private
    def initialize(token:, include_private:)
      @token = token
      @include_private = include_private
    end

    def get
      if include_private
        self.class.get("/wiwo?include_private=1",
        headers: { 'Authorization' => "Bearer #{token}" } )
      else
        self.class.get("/wiwo",
        headers: { 'Authorization' => "Bearer #{token}" } )
      end
    end
  end
end
