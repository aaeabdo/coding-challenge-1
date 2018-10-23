require 'dcf'

module DCF
  class TreetopParser
    def self.call(input)
      Dcf.parse(input)
    end
  end
end
