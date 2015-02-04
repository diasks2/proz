require 'httparty'

module Proz
  class Freelancer
    include HTTParty
    base_uri 'https://api.proz.com/v2'
    attr_reader :key, :uuid
    def initialize(key:, uuid:)
      @key = key
      @uuid = uuid
    end

    def freelancer
      @freelancer ||= self.class.get("/freelancer/#{uuid}", headers: { 'X-Proz-API-Key' => key})['data']
    end

    def method_missing(name, *args, &block)
      freelancer.has_key?(name.to_s) ? freelancer[name.to_s] : super
    end
  end
end
