require 'httparty'

module Proz
  class Profile
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :token
    def initialize(token:)
      @token = token
    end

    def profile
      self.class.get("/freelancer/me", headers: { 'Authorization' => "Bearer #{token}" })
    end
  end
end