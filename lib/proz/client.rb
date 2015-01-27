require 'httparty'

FREELANCER_URL = "/freelancer/"

module Proz
  class Client
    include HTTParty
    base_uri "https://api.proz.com/v2"
    attr_reader :key
    def initialize(key:)
      @key = key
    end

    def freelancer(uuid)
      self.class.get("/freelancer/#{uuid}", headers: { 'X-Proz-API-Key' => key})['data']
    end

    def freelancer_matches(language_pair, options)
      all_options = language_pair.merge!(options)
      self.class.get("/freelancer-matches", query: all_options, headers: { 'X-Proz-API-Key' => key})['data']
    end
  end
end