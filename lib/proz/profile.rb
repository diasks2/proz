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
      @profile ||= self.class.get("/freelancer/me", headers: { 'Authorization' => "Bearer #{token}" })['data']
    end

    def method_missing(name, *args, &block)
      profile.has_key?(name.to_s) ? profile[name.to_s] : super
    end
  end
end