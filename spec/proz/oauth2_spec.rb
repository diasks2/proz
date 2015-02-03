require 'spec_helper'

RSpec.describe Proz::OAuth2 do

  it 'sets the client_id' do
    oauth2 = Proz::OAuth2.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.client_id).to eq('abcdef')
  end

  it 'sets the client_secret' do
    oauth2 = Proz::OAuth2.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.client_secret).to eq('xyz123')
  end

  it 'sets the redirect_uri' do
    oauth2 = Proz::OAuth2.new(client_id: 'abcdef', client_secret: 'xyz123', redirect_uri: 'https://www.example.com')
    expect(oauth2.redirect_uri).to eq('https://www.example.com')
  end
end
