require_relative '../base'

module Representers::V1
  class Package < Representers::Base
    def self.member(package)
      {
        name:             package.name,
        version:          package.version,
        publication_date: package.publication_date,
        title:            package.title,
        description:      package.description,
        authors:          package.authors,
        maintainers:      package.maintainers
      }
    end

    def self.collection(collection)
      {
        packages: collection.map { |member| self.member(member) }
      }
    end
  end
end
