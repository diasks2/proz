module Proz
  class OAuth2
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
      token
    end

    def access_token
      token.token
    end

    def refresh_token
      token.refresh_token
    end

    def profile(token)
      token.get('https://api.proz.com/v2/freelancer/me')
    end

    private

    def client
      @client ||= OAuth2::Client.new(client_id, client_secret, :site => 'https://www.proz.com')
    end

    def token(code)
      @token ||= client.auth_code.get_token(code, :redirect_uri => redirect_uri, :scope => '')
    end
  end
end