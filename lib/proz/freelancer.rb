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
      case
      when freelancer_response.has_key?('error')
        if freelancer_response['error'].eql?('invalid_api_key')
          raise 'Invalid API Key'
        else
          raise 'Invalid Request'
        end
      when freelancer_response.has_key?('error_messages')
        if freelancer_response['error_messages'][0].eql?('No freelancer was found with that UUID.')
          raise 'No freelancer was found with that UUID'
        else
          raise 'Invalid Request'
        end
      else
        freelancer_response['data']
      end
    end

    def method_missing(name, *args, &block)
      freelancer.has_key?(name.to_s) ? freelancer[name.to_s] : super
    end

    private

    def freelancer_response
      @freelancer_response ||= self.class.get("/freelancer/#{uuid}", headers: { 'X-Proz-API-Key' => key})
    end
  end
end
