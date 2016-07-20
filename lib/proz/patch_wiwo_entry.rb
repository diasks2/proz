require 'httparty'

module Proz
  class PatchWiwoEntry
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token, :wiwo_id, :options
    def initialize(token:, wiwo_id:, **options)
      @token = token
      @wiwo_id = wiwo_id
      @options = options
    end

    def patch
      self.class.patch("/wiwo/#{wiwo_id}",
        body: options,
        headers: { 'Authorization' => "Bearer #{token}" } )
    end
  end
end
