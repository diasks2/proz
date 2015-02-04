require 'spec_helper'

RSpec.describe Proz::Client do

  it 'must have the base url set to the ProZ API endpoint' do
    expect(Proz::Client.base_uri).to eq('https://api.proz.com/v2')
  end

  it 'sets the client' do
    client = Proz::Client.new(key: 'xxxxxxxxxx')
    expect(client.key).to eq('xxxxxxxxxx')
  end

  it 'returns a freelancer' do
    VCR.use_cassette 'freelancer' do
      client = Proz::Client.new(key: 'xxxxxxxxxx')
      expect(client.freelancer('663e4488-58a1-4713-992c-c6d90aafa3cb')['site_name']).to eq('Smartranslators')
    end
  end

  it 'returns a freelancer match query' do
    VCR.use_cassette 'match_query' do
      client = Proz::Client.new(key: 'xxxxxxxxx')
      language_pair = { language_pair: 'eng_esl' }
      options = {}
      expect(client.freelancer_matches(language_pair, options).size).to eq(10)
    end
  end

  it 'returns a freelancer match query' do
    VCR.use_cassette 'match_query' do
      client = Proz::Client.new(key: 'xxxxxxxxx')
      language_pair = { language_pair: 'eng_esl' }
      options = {}
      expect(client.freelancer_matches(language_pair, options)[0]['freelancer']['uuid']).to eq('663e4488-58a1-4713-992c-c6d90aafa3cb')
    end
  end
end
