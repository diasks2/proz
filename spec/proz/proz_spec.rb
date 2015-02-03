require 'spec_helper'

RSpec.describe Proz::Client do

  it 'sets the client' do
    client = Proz::Client.new(key: 'x34454432')
    expect(client.key).to eq('x34454432')
  end

  it 'returns a freelancer' do
    client = Proz::Client.new(key: 'x34454432')
    expect(client.freelancer('663e4488-58a1-4713-992c-c6d90aafa3cb')['site_name']).to eq('Smartranslators')
  end

  it 'returns a freelancer match query' do
    client = Proz::Client.new(key: 'x34454432')
    language_pair = { language_pair: 'eng_esl' }
    options = {}
    expect(client.freelancer_matches(language_pair, options).size).to eq(10)
  end
end
