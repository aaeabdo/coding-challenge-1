require 'httpi'

module HTTP
  class Client
    def self.get(url)
      # TODO: make log option configurable
      HTTPI.log = false
      HTTPI.get(url)
    end
  end
end
