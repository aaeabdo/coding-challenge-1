require 'yaml'

module DCF
  class YamlParser
    def self.call(input, limit = nil)
      input_split = split_input(input)
      input_split = input_split.first(limit) if limit.present?
      input_split.collect { |p| YAML.load(p) }
    end

    class << self
      private

      def split_input(input)
        input.split("\n\n")
      end

      def limit(input, limit)
        input.first(limit)
      end
    end
  end
end
