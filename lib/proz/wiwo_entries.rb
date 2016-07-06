require 'httparty'

module Proz
  class WiwoEntries
    include HTTParty
     base_uri "https://api.proz.com/v2"

    def entries
      self.class.get("/workstatus/search")
    end
  end
end
