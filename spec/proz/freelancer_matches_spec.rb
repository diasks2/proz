require 'spec_helper'

RSpec.describe Proz::FreelancerMatches do

  it 'must have the base url set to the ProZ API endpoint' do
    expect(Proz::FreelancerMatches.base_uri).to eq('https://api.proz.com/v2')
  end

  it 'returns a freelancer match query' do
    VCR.use_cassette 'match_query' do
      fm = Proz::FreelancerMatches.new(key: 'xxxxxxxxx', language_pair: 'eng_esl')
      expect(fm.freelancer_matches.size).to eq(10)
    end
  end

  it 'returns a freelancer match query' do
    VCR.use_cassette 'match_query' do
      fm = Proz::FreelancerMatches.new(key: 'xxxxxxxxx', language_pair: 'eng_esl')
      expect(fm.freelancer_matches[0]['freelancer']['uuid']).to eq('663e4488-58a1-4713-992c-c6d90aafa3cb')
    end
  end

  it 'returns a freelancer match query with options specified' do
    VCR.use_cassette 'match_query_options' do
      fm = Proz::FreelancerMatches.new(key: 'xxxxxxxxx', language_pair: 'eng_esl', min_yrs_proz: 10, country_code: 'us')
      expect(fm.freelancer_matches[0]['freelancer']['uuid']).to eq('b9eade6d-33ac-4c7d-b6f1-42905375fc0b')
    end
  end

  it 'returns an error if the key is invalid' do
    VCR.use_cassette 'freelancer_matches_invalid_key' do
      fm = Proz::FreelancerMatches.new(key: 'yyyyyyyyy', language_pair: 'eng_esl', min_yrs_proz: 10, country_code: 'us')
      expect { fm.freelancer_matches }.to raise_error("Invalid API Key")
    end
  end

  it 'returns an empty hash if the query has no results' do
    VCR.use_cassette 'freelancer_matches_no_results' do
      fm = Proz::FreelancerMatches.new(key: 'xxxxxxxxx', language_pair: 'eng_esl', min_yrs_proz: 50, country_code: 'us')
      expect(fm.freelancer_matches).to eq({})
    end
  end
end
