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
      case
      when profile_response.has_key?('error')
        if profile_response['error'].eql?('invalid_token')
          raise 'Invalid Token'
        elsif profile_response['error'].eql?('expired_token')
          raise 'Access Token Expired'
        else
          raise 'Invalid Request'
        end
      else
        profile_response['data']
      end
    end

    def method_missing(name, *args, &block)
      profile.has_key?(name.to_s) ? profile[name.to_s] : super
    end

    private

    def profile_response
      @profile ||= self.class.get("/freelancer/me", headers: { 'Authorization' => "Bearer #{token}" })
    end
  end
end
