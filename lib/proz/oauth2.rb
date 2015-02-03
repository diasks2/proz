module Proz
  class OAuth2
    attr_reader :client_id, :client_secret, :redirect_uri
    def initialize(client_id:, client_secret:, redirect_uri:)
      @client_id = client_id
      @client_secret = client_secret
      @redirect_uri = redirect_uri
    end

    def link
      client = OAuth2::Client.new(client_id, client_secret, :site => 'https://www.proz.com')
      client.auth_code.authorize_url(:redirect_uri => redirect_uri)
    end
  end
end