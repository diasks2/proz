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
      case
      when freelancer_matches_response.has_key?('error')
        if freelancer_matches_response['error'].eql?('invalid_api_key')
          raise 'Invalid API Key'
        else
          raise 'Invalid Request'
        end
      when freelancer_matches_response.has_key?('meta')
        if freelancer_matches_response['meta']['num_results'].eql?(0)
          {}
        else
          freelancer_matches_response['data']
        end
      else
        freelancer_matches_response['data']
      end
    end

    private

    def freelancer_matches_response
      all_options = language_pair.merge!(options)
      @freelancer_matches_response ||= self.class.get("/freelancer-matches", query: all_options, headers: { 'X-Proz-API-Key' => key})
    end
  end
end
