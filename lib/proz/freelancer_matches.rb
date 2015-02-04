require 'httparty'

module Proz
  class FreelancerMatches
    include HTTParty
    base_uri 'https://api.proz.com/v2'
    attr_reader :key, :language_pair, :options
    def initialize(key:, language_pair:, **options)
      @key = key
      @language_pair = { language_pair: language_pair }
      @options = options
    end

    def freelancer_matches
      all_options = language_pair.merge!(options)
      self.class.get("/freelancer-matches", query: all_options, headers: { 'X-Proz-API-Key' => key})['data']
    end
  end
end
