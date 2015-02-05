require 'oauth2'
require 'httparty'

module Proz
  class OAuth
    include HTTParty
    attr_reader :client_id, :client_secret, :redirect_uri
    def initialize(client_id:, client_secret:, redirect_uri:)
      @client_id = client_id
      @client_secret = client_secret
      @redirect_uri = redirect_uri
    end

    def link
      client.auth_code.authorize_url(:redirect_uri => redirect_uri)
    end

    def exchange_code_for_token(code)
      if token(code).has_key?('error')
        if token(code)['error'].eql?('invalid_grant')
          raise "Authorization code doesn't exist or is invalid for the client"
        else
          raise 'Invalid Request'
        end
      else
        token(code)
      end
    end

    def request_new_token_with_refresh_token(refresh_token)
      @refreshed_token ||= self.class.post('https://www.proz.com/oauth/token', :body => { :refresh_token => refresh_token, :redirect_uri => redirect_uri, :client_id => client_id, :client_secret => client_secret, :grant_type => 'refresh_token' })
    end

    private

    def token(code)
      @token ||= self.class.post('https://www.proz.com/oauth/token', :body => { :code => code, :redirect_uri => redirect_uri, :client_id => client_id, :client_secret => client_secret, :grant_type => 'authorization_code' })
    end

    def client
      @client ||= OAuth2::Client.new(client_id, client_secret, :site => 'https://www.proz.com')
    end
  end
end
