require 'httparty'

module Proz
  class GetSinglePublicWiwoEntry
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :key, :wiwo_id
    def initialize(key:, wiwo_id:)
      @key = key
      @wiwo_id = wiwo_id
    end

    def get
      self.class.get("/wiwo/#{wiwo_id}", headers: { 'X-Proz-API-Key' => "#{key}" } )
    end
  end
end
