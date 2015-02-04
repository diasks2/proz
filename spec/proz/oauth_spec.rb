require 'spec_helper'

RSpec.describe Proz::OAuth do

  it 'sets the client_id' do
    oauth2 = Proz::OAuth.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.client_id).to eq('abcdef')
  end

  it 'sets the client_secret' do
    oauth2 = Proz::OAuth.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.client_secret).to eq('xyz123')
  end

  it 'sets the redirect_uri' do
    oauth2 = Proz::OAuth.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.redirect_uri).to eq('https://www.example.com')
  end

  it 'returns a link for the user to authorize the app' do
    proz = Proz::OAuth.new(client_id: 'abc123xxxxxxxxxxxxxx', client_secret: 'abc123xxxxyyyyy', redirect_uri: 'http://www.example.com')
    expect(proz.link).to eq("https://www.proz.com/oauth/authorize?client_id=abc123xxxxxxxxxxxxxx&redirect_uri=http%3A%2F%2Fwww.example.com&response_type=code&scope=proz")
  end

  it 'exchanges a code for an access token' do
    VCR.use_cassette 'exchange_code_for_token' do
      proz = Proz::OAuth.new(client_id: 'xxxxxxxxx', client_secret: 'yyyyyyyyy', redirect_uri: 'http://www.example.com')
      expect(proz.exchange_code_for_token('xf505e6ac620cb51bb8dc99d4bddbef2f3122e70')['access_token']).to eq('q0245b8b893717386310160f117d1720583f3d22')
      expect(proz.exchange_code_for_token('xf505e6ac620cb51bb8dc99d4bddbef2f3122e70')['refresh_token']).to eq('g197d8ba9dd0c608ee6e2c83c3b363540ec14b31')
    end
  end

  it 'requests a new token with the refresh token' do
    VCR.use_cassette 'refresh_token' do
      proz = Proz::OAuth.new(client_id: 'xxxxxxxxx', client_secret: 'yyyyyyyyy', redirect_uri: 'http://www.example.com')
      expect(proz.request_new_token_with_refresh_token('x92701ac20cb02a5742f2a0288b7a9f6a6d0b265')['access_token']).to eq('x325fa5d0a661df967a6c52d07ba352649a7c153')
      expect(proz.request_new_token_with_refresh_token('x92701ac20cb02a5742f2a0288b7a9f6a6d0b265')['refresh_token']).to eq('x6ee311617f0f0520e99de13b07ee61c03777134')
    end
  end
end
